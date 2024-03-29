import { CardService } from 'src/app/services/card.service';
import { Component, OnInit, Input } from '@angular/core';
import { Card } from 'src/app/models/card';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-card-list',
  templateUrl: './card-list.component.html',
  styleUrls: ['./card-list.component.css'],
})
export class CardListComponent implements OnInit {
  constructor(
    private cardService: CardService,
    private userService: UserService
  ) {}

  @Input() user: User | null = null;
  cardList: Card[] = [];
  selected: Card | null = null;
  newCard = new Card();
  editCard: Card | null = null;
  showForm = false;
  rarities: string[] = [
    "All",
    'BasicLand',
    'Common',
    'Uncommon',
    'Rare',
    'MythicRare',
  ];
  selectedRarity = 'All';
  userCards=false;

  ngOnInit(): void {
    this.loadAllCards();
    // this.loadMTGCards();
  }

  loadAllCards() {
    this.cardService.index().subscribe({
      next: (cardList) => {
        this.cardList = cardList;
        return cardList;
      },
      error: (card) => {
        console.error('CardListComponent.LoadCards(): error loading Cards:');
        console.error(card);
      },
    });
  }

  // loadMTGCards() {
  //   this.cardService.getMTGCards().subscribe({
  //     next: (cardList) => {
  //       this.cardList = cardList;
  //       return cardList;
  //     },
  //     error: (card) => {
  //       console.error('CardListComponent.LoadCards(): error loading Cards:');
  //       console.error(card);
  //     },
  //   });
  // }


  loadUserCards(userId?: number) {
    console.log(userId)
    this.cardService.index(userId).subscribe({
      next: (cardList) => {
       this.cardList=cardList
        return cardList;
      },
      error: (card) => {
        console.error('CardListComponent.LoadCards(): error loading Cards:');
        console.error(card);
      },
    });
  }


  getAddForm() {
    this.showForm = !this.showForm;
    this.selected = null;
    this.editCard = null;
  }

  addCard(newCard: Card) {
    this.cardService.create(newCard).subscribe({
      next: (result) => {
        this.loadAllCards();
        this.showForm = false;
        this.newCard = new Card();
      },
      error: (nojoy) => {
        console.error('CardListHttpComponent.addCard(): error creating Card:');
        console.error(nojoy);
      },
    });
  }

  updateTodo(editCard: Card) {
    this.cardService.update(editCard).subscribe({
      next: (result) => {
        this.loadAllCards();
        this.selected = editCard;
        this.editCard = null;
      },
      error: (nojoy) => {
        console.error('CardListComponent.UpdateCard(): error Updating Card:');
        console.error(nojoy);
      },
    });
  }

  setEditCard(editCard: Card) {
    this.editCard = Object.assign({}, this.selected);
  }

  deleteCard(id: number) {
    this.cardService.delete(id).subscribe({
      next: (result) => {
        this.loadAllCards();
        this.selected = null;
        this.editCard = null;
      },
      error: (nojoy) => {
        console.error('CardLisComponent.DeleteCard(): error Deleting Card:');
        console.error(nojoy);
      },
    });
  }

  addCardToUser(card: Card) {
    if (this.user) {
      this.userService.addCardToUser(this.user.id, card).subscribe({
        next: (result) => {
          if(this.user) {
            this.user.deckBuilder.push(card);
          this.loadUserCards(this.user.id)
          }
        },
        error: (nojoy) => {
          console.error('CardLisComponent.addCardToUser(): error adding Card To User:');
          console.error(nojoy);
        },
      });
    }
  }

 removeCardFromUser(card: Card) {
  if (this.user) {
    console.log(this.user.id + " " + card.id);
    this.userService.removeCardFromUser(this.user.id, card).subscribe({
      next: (result) => {
        if (this.user?.deckBuilder) {
          let index = this.user.deckBuilder.indexOf(card);
          if (index !== -1) {
            this.user.deckBuilder.splice(index, 1);

          }
        }
      },
      error: (nojoy) => {
        console.error('CardLisComponent.addCardToUser(): error adding Card To User:');
        console.error(nojoy);
      },
    });
  }
}



  displayCard(card: Card) {
    this.selected = card;
  }

  displayTable() {
    this.selected = null;
  }

  cancelEdit(editCard: Card) {
    this.editCard = null;
  }
}
