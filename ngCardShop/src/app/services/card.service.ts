//import { environment } from './../environments/environment.development';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { Card } from 'src/app/models/card';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CardService {

  url: string = environment.baseUrl + 'api/cards';




  constructor(private http: HttpClient) { }




  index(): Observable<Card[]> {
    return this.http.get<Card[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'CardService.index(): error retrieving Cards: ' + err
            )
        );
      })
    );
  }

  create(card: Card): Observable<Card> {
    return this.http.post<Card>(this.url,card).pipe(
      catchError((err:any) =>{
        console.error(err);
        return throwError(
          () => new Error('CardService.create(): error creating Card: ' + err)
        );
      })
    );
  }

  update(editCard: Card):  Observable<Card> {
    return this.http.put<Card>(this.url + "/" + editCard.id,editCard).pipe(
      catchError((err:any) =>{
        console.error(err);
        return throwError(
          () => new Error('CardService.update(): error Updating Card: ' + err)
        );
      })
    );
  }

  delete(id: number): Observable<void> {
    return this.http.delete<void>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('CardService.delete(): error deleting Card: ' + err)
        );
      })
    );
  }

  show(id: number): Observable<Card> {
    return this.http.get<Card>(this.url + "/" + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'CardService.Show(): error retrieving Card: ' + err
            )
        );
      })
    );
  }








}
