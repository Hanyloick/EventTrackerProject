import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { Card } from '../models/card';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  url: string = environment.baseUrl + 'api/users';

  constructor(private http: HttpClient) {}

  show(username: string, password: string): Observable<User> {
    return this.http.get<User>(this.url + '/' + username + '/' + password).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.Show(): error retrieving User: ' + err)
        );
      })
    );
  }

  create(user: User): Observable<User> {
    return this.http.post<User>(this.url, user).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('CardService.index(): error retrieving Cards: ' + err)
        );
      })
    );
  }

  addCardToUser(userId: number, card: Card): Observable<User> {
    console.log(userId + " " + card.id)
    return this.http.put<User>(this.url + '/' + userId + '/' + card.id, null).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.AddCardToUser(): error retrieving User: ' + err)
        );
      })
    );
  }
}
