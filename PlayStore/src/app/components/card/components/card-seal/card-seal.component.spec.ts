import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CardSealComponent } from './card-seal.component';

describe('CardSealComponent', () => {
  let component: CardSealComponent;
  let fixture: ComponentFixture<CardSealComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CardSealComponent]
    });
    fixture = TestBed.createComponent(CardSealComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
