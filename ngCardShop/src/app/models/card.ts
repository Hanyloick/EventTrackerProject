export class Card {
  id: number;
  name: string;
  type: string;
  cost: string;
  rarity: string;
  imageURL: string;

  constructor(
    id:number =0,
    name:string='',
    type:string='',
    cost:string='',
    rarity:string='',
    imageURL:string=''
  ) {
    this.id = id;
    this.name=name;
    this.type=type;
    this.cost=cost;
    this.rarity=rarity;
    this.imageURL=imageURL;
  }






}
