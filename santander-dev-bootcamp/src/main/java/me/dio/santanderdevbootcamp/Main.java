package me.dio.santanderdevbootcamp;

import me.dio.santanderdevbootcamp.domain.model.Account;
import me.dio.santanderdevbootcamp.domain.model.Card;
import me.dio.santanderdevbootcamp.domain.model.User;

import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        var cliente=new User("User1");
        System.out.println("--------"+cliente);
        var account=new Account("0001", new BigDecimal("2000.0"),new BigDecimal("200.0"));
        cliente.setAccount(account);

        var card=new Card(cliente.getAccount(),new BigDecimal("2000.0"));
        cliente.getAccount().setCards(card);

        System.out.println(cliente);
    }
}
