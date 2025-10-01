package org.example.core.domain.local;

public enum EnderecoStatus {
   PRINCIPAL, SECUNDARIO, INATIVO;

   public boolean isAtivo() {
      return this != EnderecoStatus.INATIVO;
   }

   public boolean isPrincipal(){
      return this == EnderecoStatus.PRINCIPAL;
   }

   public boolean isSecundario() {
      return this == EnderecoStatus.SECUNDARIO;
   }

}
