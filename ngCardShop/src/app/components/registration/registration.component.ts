import { Component, EventEmitter, Output } from '@angular/core';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent {


  user: User | null = null;
  newUser = new User();
  showForm = true;

  constructor(private userService:UserService){}



  register() {
    this.userService.create(this.newUser).subscribe ({
      next: (result) => {
        this.showForm = false;
        this.handleRegistrationSuccess(result);

      },
      error: (nojoy) => {
        console.error('loginComponent.login(): login error:');
        console.error(nojoy);
      },
    });
  }

  @Output() registrationSuccess: EventEmitter<User> = new EventEmitter<User>();

  handleRegistrationSuccess(user: User) {
    this.registrationSuccess.emit(user);
  }
}


