import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';
import { CardListComponent } from './components/card-list/card-list.component';
import { HomeComponent } from './components/home/home.component';
import { CardRaritiesPipe } from './pipes/card-rarities.pipe';


@NgModule({
  declarations: [
    AppComponent,
    CardListComponent,
    HomeComponent,
    CardRaritiesPipe
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
