import { Card } from "./card";

export class User {
  id:number;
  username:string;
  password:string;
  firstName:string;
  lastName:string;
  imageURL:string
  deckBuilder:Card[];

  constructor(
    id:number=0,
    username:string='',
    password:string='',
    firstName:string='',
    lastName:string='',
    imageURL:string='',
    deckBuilder:Card[] = []
  ) {
    this.id=id;
    this.username=username;
    this.password=password;
    this.firstName=firstName;
    this.lastName=lastName;
    this.imageURL=imageURL;
    this.deckBuilder=deckBuilder;
  }












}
