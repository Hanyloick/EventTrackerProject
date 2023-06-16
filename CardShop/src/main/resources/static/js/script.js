window.addEventListener('load', function(event) {
	init();
});


function init() {
	getAllCards();

}


function getAllCards() {
	let xhr = new XMLHttpRequest();
	xhr.open('GET', 'api/cards', true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState === xhr.DONE) {
			console.log('in ready state change' + xhr.readyState);
			if (xhr.status === 200) {
				let cards = JSON.parse(xhr.responseText);
				displayCards(cards);
				buildAddFormButton(cards)
			} else if (xhr.status === 404) {
				console.error('Cards not found.')
			} else {
				console.error(xhr.status + ': ' + xhr.responseText);
			}
		}
	};
	xhr.send();
}

function displayCards(cards) {
	buildTable(cards);
	let updateDiv = document.getElementById('updateDiv');
	updateDiv.textContent = '';
	let addDiv = document.getElementById('addDiv');
	addDiv.textContent = '';
}

function buildTable(collection) {
	let tableDiv = document.getElementById('tableDiv');
	tableDiv.textContent = '';

	let h1 = document.createElement('h1');
	h1.textContent = 'All Entities';
	tableDiv.appendChild(h1);

	let mythicRares = 0;
	for (let single of collection) {
		for (let key in single) {
			if (key === 'rarity' && single[key] === 'MythicRare') {
				mythicRares++;
			}
		}
	}

	let h2 = document.createElement('h2');
	h2.textContent = 'There are ' + mythicRares + ' Mythic Rare Cards';
	tableDiv.appendChild(h2);

	let table = document.createElement('table');
	table.appendChild(createTableHead(collection));
	table.appendChild(createTableBody(collection));
	tableDiv.appendChild(table);
}

function createTableHead(collection) {
	let tableHead = document.createElement('thead');
	let headerRow = document.createElement('tr');
	for (let key in collection[0]) {
		let th = document.createElement("th");
		if (key === 'imageURL') {
			th.textContent = 'Image';
		} else {
			th.textContent = key;
		}
		headerRow.appendChild(th);
	}
	tableHead.appendChild(headerRow);

	return tableHead;
}

function createTableBody(collection) {
	let mainDiv = document.getElementsByClassName('main-container')[0];
	let tbody = document.createElement('tbody');
	for (let single of collection) {
		let tr = document.createElement('tr');
		for (let key in single) {
			let td = document.createElement('td');

			if (key === 'imageURL') {
				let img = document.createElement('img');
				img.src = single[key];
				img.alt = 'Image';
				img.style.width = '50%'
				td.appendChild(img);
			} else {
				td.textContent = single[key];
			}


			tr.appendChild(td);
			tr.addEventListener('click', function(event) {
				let singleId = single.id;
				getTableDetails(singleId)
				//	buildAddForm(single);
			});
		}

		tbody.appendChild(tr);
	}

	return tbody;
}

function getTableDetails(cardId) {
	let xhr = new XMLHttpRequest();

	xhr.open('GET', 'api/cards/' + cardId, true);

	xhr.onreadystatechange = function() {
		if (xhr.readyState === xhr.DONE) {
			console.log('in ready state change' + xhr.readyState);
			if (xhr.status === 200) {
				let card = JSON.parse(xhr.responseText);
				displayUpdateDetails(card);
			} else if (xhr.status === 404) {
				console.error('Cards not found.')
			} else {
				console.error(xhr.status + ': ' + xhr.responseText);
			}
		}
	};
	xhr.send();

}

function displayUpdateDetails(card) {
	//TODO DOM -display details div
	displayCard(card);
	let updateDiv = document.getElementById('updateDiv');
	updateDiv.textContent = '';
	let updateForm = document.createElement('form');
	updateForm.name = 'updateForm';
	updateForm.className = 'update-form';
	let h1 = document.createElement('h1');
	h1.textContent = 'Update or Delete Your Selection: ';
	updateDiv.appendChild(h1);



	for (let fieldName in card) {
		let formGroup = document.createElement('div');
		formGroup.className = 'form-group';
		let input = document.createElement('input');
		input.name = fieldName;

		if (typeof card[fieldName] === 'number') {
			if (fieldName === 'id') {
				input.type = 'hidden'
			} else {
				input.type = 'number';
			}
		} else if (typeof card[fieldName] === 'string') {
			input.type === 'text';
		}

		if (card[fieldName] === input.value) {
			input.value = card[fieldName];
		}

		input.value = card[fieldName];
		formGroup.appendChild(input);
		updateForm.appendChild(formGroup);
	}



	let submitButton = document.createElement('button');
	submitButton.type = 'submit'
	submitButton.textContent = 'Update';
	submitButton.className = 'btn btn-outline-success';
	updateForm.appendChild(submitButton);

	submitButton.addEventListener('click', function(event) {
		event.preventDefault();
		let collectedFormData = getFormData(updateForm);
		updateCard(collectedFormData);
	});
	updateDiv.appendChild(updateForm)

	let deleteForm = document.createElement('form')
	deleteForm.name = 'deleteForm'
	let cardId = document.createElement('input')
	cardId.type = 'hidden'
	cardId.value = card.id;
	let deleteButton = document.createElement('button')
	deleteButton.type = 'submit';
	deleteButton.textContent = 'Delete'
	deleteButton.className = 'btn btn-outline-danger';
	deleteForm.appendChild(cardId)
	deleteForm.appendChild(deleteButton)
	updateDiv.appendChild(deleteForm)

	deleteButton.addEventListener('click', function(event) {
		event.preventDefault();

		deleteItem(card.id);
	});


}

function buildAddFormButton(cards) {
	let addDiv = document.getElementById('addDiv');
	let addFormButton = document.createElement('button');
	addFormButton.textContent = 'Add A New Card';
	addFormButton.className = 'btn btn-outline-success';
	addDiv.appendChild(addFormButton);
	addFormButton.addEventListener('click', function(event) {
		buildAddForm(cards);

	});
}

function buildAddForm(cards) {
	let card = cards[0];
	let addDiv = document.getElementById('addDiv');
	addDiv.textContent = '';
	let tableDiv = document.getElementById('tableDiv');
	tableDiv.textContent = '';
	let displayAllButton = document.createElement('button')
	displayAllButton.className = 'btn btn-outline-success';
	displayAllButton.textContent = 'View All Cards'
	addDiv.appendChild(displayAllButton);
	displayAllButton.addEventListener('click', function() {
		getAllCards();
	});
	let h1 = document.createElement('h1');
	h1.textContent = 'Add A New Item!';
	addDiv.appendChild(h1);

	let addForm = document.createElement('form');
	addForm.className = 'add-form'; // Add a CSS class to the form for stylig

	for (let fieldName in card) {
		if (fieldName != 'id') {
			let formGroup = document.createElement('div');
			formGroup.className = 'form-group';



			let input = document.createElement('input');
			input.name = fieldName;

			if (typeof card[fieldName] === 'number') {
				if (fieldName === 'id') {
					continue;
				} else {
					input.type = 'number';
				}
			} else if (typeof card[fieldName] === 'string') {
				input.type = 'text'; // Fix the typo here
			}

			input.placeholder = fieldName;

			formGroup.appendChild(input);
			addForm.appendChild(formGroup);
		}
	}

	let submitButton = document.createElement('button');
	submitButton.className = 'btn btn-outline-success';
	submitButton.type = 'submit';
	submitButton.textContent = 'Create';
	addForm.appendChild(submitButton);

	submitButton.addEventListener('click', function(event) {
		event.preventDefault();
		let collectedFormData = getFormData(addForm);
		addCard(collectedFormData);
	});


	addDiv.appendChild(addForm);
}


function addCard(card) {
	let xhr = new XMLHttpRequest();

	xhr.open('POST', 'api/cards', true);
	xhr.setRequestHeader("Content-type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === xhr.DONE) {
			if (xhr.status === 201) {
				let card = JSON.parse(xhr.responseText);
				getAllCards();
			} else if (xhr.status === 404) {
				console.error('Cards not found.')
			} else {
				console.error(xhr.status + ': ' + xhr.responseText);
			}
		}
	};
	let cardString = JSON.stringify(card);
	xhr.send(cardString);
}



function deleteItem(cardId) {

	let xhr = new XMLHttpRequest();
	xhr.open('DELETE', 'api/cards/' + cardId, true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState === xhr.DONE) {
			if (xhr.status === 204) {
				getAllCards();

			} else if (xhr.status === 404) {

			} else {
				console.error(xhr.status + ': ' + xhr.responseText);
			}
		}
	};
	xhr.send();
}

function updateCard(card) {
	let xhr = new XMLHttpRequest();

	xhr.open('PUT', 'api/cards/' + card.id, true);
	xhr.setRequestHeader("Content-type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === xhr.DONE) {
			if (xhr.status === 200) {
				let cards = JSON.parse(xhr.responseText);
				displayCard(card);
			} else if (xhr.status === 404) {
				console.error('Cards not found.')
			} else {
				console.error(xhr.status + ': ' + xhr.responseText);
			}
		}
	};
	let cardString = JSON.stringify(card);
	xhr.send(cardString);
}

function getFormData(updateForm) {
	let formData = new FormData(updateForm);
	let updatedData = {};
	formData.forEach(function(value, fieldName) {
		updatedData[fieldName] = value;
	})
	return updatedData;
}

function displayCard(card) {
	buildTableForSingle(card);
}


function buildTableForSingle(card) {
	let tableDiv = document.getElementById('tableDiv')
	tableDiv.textContent = '';
	let displayAllButton = document.createElement('button')
	displayAllButton.className = 'btn btn-outline-success';
	displayAllButton.textContent = 'View All Cards'
	tableDiv.appendChild(displayAllButton);
	displayAllButton.addEventListener('click', function() {
		getAllCards();
	});
	let h1 = document.createElement('h1');
	h1.textContent = 'You Selected: '
	tableDiv.appendChild(h1);
	let table = document.createElement('table');
	table.id = 'single Display';
	table.className = 'table table-dark table-hover'
	table.textContent = '';
	table.appendChild(createTableHeadForSingle(card));
	table.appendChild(createTableBodyForSingle(card));
	tableDiv.appendChild(table);
}

function createTableHeadForSingle(card) {
	let tableHead = document.createElement('thead');
	let headerRow = document.createElement('tr');
	for (let key in card) {
		let th = document.createElement("th");
		if (key === 'imageURL') {
			th.textContent = 'Image';
		} else {
			th.textContent = key;
		}
		headerRow.appendChild(th);
	}
	tableHead.appendChild(headerRow);
	return tableHead;
}

function createTableBodyForSingle(single) {
	let tbody = document.createElement('tbody');
	let tr = document.createElement('tr')

	for (let key in single) {
		let td = document.createElement('td');

		if (key === 'imageURL') {
			let img = document.createElement('img');
			img.src = single[key];
			img.alt = 'Image';
			img.style.width = '50%'
			td.appendChild(img);
		} else {
			td.textContent = single[key];
		}
		tr.appendChild(td);
		tbody.appendChild(tr);
	}

	return tbody;
}