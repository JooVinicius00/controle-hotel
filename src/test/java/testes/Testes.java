package testes;
public class Testes {
    private static int verificacoes;
    private static void conferir(boolean valor) {
        verificacoes++;
        if (!valor) throw new AssertionError("Falha na verificação " + verificacoes);
    }
    private static void perto(double esperado, double valor) {
        conferir(Math.abs(esperado - valor) < 0.000001);
    }
    private static void rejeitar(Runnable acao) {
        verificacoes++;
        try { acao.run(); } catch (IllegalArgumentException erro) { return; }
        throw new AssertionError("Entrada inválida foi aceita.");
    }
    public static void main(String[] args) throws Exception {

        darwin.OcupacaoHotel hotel = new darwin.OcupacaoHotel();
        conferir(!hotel.estaOcupado(5, 5)); hotel.definir(5, 5, true); conferir(hotel.estaOcupado(5, 5));
        conferir(!hotel.estaOcupado(1, 1)); conferir(hotel.listar().contains("5 | 5 | Ocupado"));
        hotel.definir(5, 5, false); conferir(!hotel.estaOcupado(5, 5));
        conferir(hotel.listar().split("\n").length == 26);
        rejeitar(() -> hotel.definir(0, 1, true)); rejeitar(() -> hotel.definir(1, 6, true));

        System.out.println("OK: " + verificacoes + " verificações.");
    }
}
