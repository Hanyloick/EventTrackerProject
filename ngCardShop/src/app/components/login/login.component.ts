import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})

export class LoginComponent implements OnInit {

  username:string ='';
  password:string ='';

  userList: User[] = [];
  user: User | null = null;
  newUser = new User();
  editUser: User | null = null;
  showForm = true;

constructor(private userService:UserService){}


ngOnInit(): void {

  }

login() {
  this.userService.show(this.username,this.password).subscribe ({
    next: (result) => {
      this.user = result;
    },
    error: (nojoy) => {
      console.error('loginComponent.login(): login error:');
      console.error(nojoy);
    },
  });
}

logout() {
  this.user = null;
}
handleRegistrationSuccess(user: User) {
  this.user = user;
}


}
