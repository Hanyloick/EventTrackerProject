import { Pipe, PipeTransform } from '@angular/core';
import { Card } from '../models/card';

@Pipe({
  name: 'cardRarities'
})
export class CardRaritiesPipe implements PipeTransform {

  transform(cardList: Card[], rarity: string): Card[] {
    if (rarity === 'All') {
      return cardList;
    } else {
      const results: Card[] = [];

      cardList.forEach(card => {
        if (card.rarity === rarity) {
          results.push(card);
        }
      });

      return results;
    }
  }
}
