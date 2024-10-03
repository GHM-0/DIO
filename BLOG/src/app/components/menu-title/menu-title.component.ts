import { Component,HostListener } from '@angular/core';

@Component({
  selector: 'app-menu-title',
  templateUrl: './menu-title.component.html',
  styleUrls: ['./menu-title.component.css']
})

export class MenuTitleComponent {
  isShrinked = false;

  // Click in
  @HostListener("click") onClick(){
    this.isShrinked = !this.isShrinked;
  }

  // Scroll /UP
  @HostListener('window:scroll') onScroll() {
    const scrollPosition = window.scrollY;
    this.isShrinked = scrollPosition > 0; 
  }

  //? May be a Timed Effect, 12 sec
}
