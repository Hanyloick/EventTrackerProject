window.addEventListener('load', function(event) {
	init();
});


function init() {
	getAllCards();
	

}


function getAllCards() {
	let xhr = new XMLHttpRequest();
	xhr.open('GET', 'http://localhost:8086/api/cards', true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState === xhr.DONE) {
			console.log('in ready state change' + xhr.readyState);
			if (xhr.status === 200) {
				let cards = JSON.parse(xhr.responseText);
				displayCards(cards);
				console.log(cards)
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
		updateDiv.textContent ='';
	let addDiv = document.getElementById('addDiv');
		addDiv.textContent='';
}

function buildTable(collection) {
	let tableDiv = document.getElementById('tableDiv')
		tableDiv.textContent = '';
	let h1 = document.createElement('h1');
		h1.textContent = 'All Entites ';
		tableDiv.appendChild(h1);	
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
		th.textContent = key;
		headerRow.appendChild(th);
	}
	tableHead.appendChild(headerRow);
	return tableHead;
}

function createTableBody(collection) {
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
				buildAddForm(single);
			});
		}

		tbody.appendChild(tr);
	}

	return tbody;
}

function getTableDetails(cardId) {
	let xhr = new XMLHttpRequest();

	xhr.open('GET', 'http://localhost:8086/api/cards/' + cardId, true);

	xhr.onreadystatechange = function() {
		if (xhr.readyState === xhr.DONE) {
			console.log('in ready state change' + xhr.readyState);
			if (xhr.status === 200) {
				let card = JSON.parse(xhr.responseText);
				displayUpdateDetails(card);
				console.log(card)
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
	let h1 = document.createElement('h1');
		h1.textContent = 'Update or Delete Your Selection: ';
		updateDiv.appendChild(h1);
	for (let fieldName in card) {
		if (fieldName != 'id') {
			let formLabel = document.createElement('label')
			formLabel.textContent = fieldName;
			updateForm.appendChild(formLabel);
		}
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
		let br = document.createElement('br');
		updateForm.appendChild(input);
		updateForm.appendChild(br);
	}
	let submitButton = document.createElement('input');
		submitButton.type = 'submit'
		submitButton.value = 'Update';
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
	let deleteButton = document.createElement('input')
		deleteButton.type = 'submit';
		deleteButton.value = 'Delete'
		deleteForm.appendChild(cardId)
		deleteForm.appendChild(deleteButton)
		updateDiv.appendChild(deleteForm)
		
		deleteButton.addEventListener('click', function(event) {
			event.preventDefault();
			
			deleteItem(card.id);
		});	
		
		let displayAllButton = document.createElement('button')
			displayAllButton.textContent = 'View All Cards Again '
			updateDiv.appendChild(displayAllButton);
			displayAllButton.addEventListener('click', function() {
				getAllCards();
			});
}

function buildAddForm(card) {
let addDiv = document.getElementById('addDiv');
	addDiv.textContent = '';
let h1 = document.createElement('h1');
	h1.textContent = 'Add A New Item!';
	addDiv.appendChild(h1);
	let addForm = document.createElement('form');
		addForm.name = 'addForm';
	for (let fieldName in card) {
		if (fieldName != 'id') {
			let formLabel = document.createElement('label')
			formLabel.textContent = fieldName;
			addForm.appendChild(formLabel);
		}
		let input = document.createElement('input');
		input.name = fieldName;

		if (typeof card[fieldName] === 'number') {
			if (fieldName === 'id') {
				continue;
			} else {
				input.type = 'number';
			}
		} else if (typeof card[fieldName] === 'string') {
			input.type === 'text';
		}

		input.placeholder = fieldName;

		
		let br = document.createElement('br');
		addForm.appendChild(input);
		addForm.appendChild(br);
	}
	let submitButton = document.createElement('input');
		submitButton.type = 'submit'
		submitButton.value = 'Update';
		addForm.appendChild(submitButton);
		
		submitButton.addEventListener('click', function(event) {
			event.preventDefault();
			let collectedFormData = getFormData(addForm);
			addCard(collectedFormData);
		});
		addDiv.appendChild(addForm)
		
		
		
}		

function addCard(card) {
	let xhr = new XMLHttpRequest();

	xhr.open('POST', 'http://localhost:8086/api/cards', true);
	xhr.setRequestHeader("Content-type", "application/json");
	
	xhr.onreadystatechange = function() {
		if (xhr.readyState === xhr.DONE) {
			console.log('in ready state change' + xhr.readyState);
			if (xhr.status === 201) {
				let card = JSON.parse(xhr.responseText);
				getAllCards();
				console.log(card)
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

	xhr.open('PUT', 'http://localhost:8086/api/cards/' + card.id, true);
	xhr.setRequestHeader("Content-type", "application/json");
	
	xhr.onreadystatechange = function() {
		if (xhr.readyState === xhr.DONE) {
			console.log('in ready state change' + xhr.readyState);
			if (xhr.status === 200) {
				let cards = JSON.parse(xhr.responseText);
				displayCard(card);
				console.log(card)
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
	
//	let name = updateForm.name.value;
//	let type = updateForm.type.value;
//	let cost = updateForm.cost.value;
//	let rarity = updateForm.rarity.value;
//	let imageURL = updateForm.imageURL.value;
 // 
//	return {
//		id: id,
 //   	name: name,
//    	type: type,
 //   	cost: cost,
 //   	rarity: rarity,
 //   	imageURL: imageURL
// // 	};
}

function displayCard(card) {
	buildTableForSingle(card);
}

function buildTableForSingle(card) {
	let tableDiv = document.getElementById('tableDiv')
	tableDiv.textContent = '';
	let h1 = document.createElement('h1');
		h1.textContent = 'You Selected: '
		tableDiv.appendChild(h1);
	let table = document.createElement('table');
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
		th.textContent = key;
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
			img.style.width = '30%'
			td.appendChild(img);
		} else {
			td.textContent = single[key];
		}
		tr.appendChild(td);
		tbody.appendChild(tr);
	}

	return tbody;
}