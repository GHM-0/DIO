import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { MenuComponent } from './components/menu/menu.component';
import { CardComponent } from './components/card/card.component';
import { HomeComponent } from './pages/home/home.component';
import { CardLabelComponent } from './components/card/components/card-label/card-label.component';
import { CardSealComponent } from './components/card/components/card-seal/card-seal.component';

@NgModule({
  declarations: [
    AppComponent,
    MenuComponent,
    CardComponent,
    HomeComponent,
    CardLabelComponent,
    CardSealComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
