using DesafioPOO.Models;

// TODO: Realizar os testes com as classes Nokia e Iphone

Smartphone telefone1 = new Nokia("123343444");
Smartphone telefone2 = new Iphone("33222222");
  
  telefone1.InstalarAplicativo("XWitter");
  telefone1.Ligar();
  telefone1.ReceberLigacao();
  
  telefone2.InstalarAplicativo("XWitter");
  telefone2.Ligar();
  telefone2.ReceberLigacao();