package darwin;

public class OcupacaoHotel {
    private final boolean[][] ocupados = new boolean[5][5];
    private void validar(int andar, int quarto) {
        if (andar < 1 || andar > 5 || quarto < 1 || quarto > 5)
            throw new IllegalArgumentException("Andar e quarto devem estar entre 1 e 5.");
    }
    public void definir(int andar, int quarto, boolean ocupado) {
        validar(andar, quarto);
        ocupados[andar - 1][quarto - 1] = ocupado;
    }
    public boolean estaOcupado(int andar, int quarto) {
        validar(andar, quarto);
        return ocupados[andar - 1][quarto - 1];
    }
    public String listar() {
        StringBuilder lista = new StringBuilder("Andar | Quarto | Ocupação\n");
        for (int andar = 1; andar <= 5; andar++) {
            for (int quarto = 1; quarto <= 5; quarto++) {
                lista.append(andar).append(" | ").append(quarto).append(" | ")
                    .append(estaOcupado(andar, quarto) ? "Ocupado" : "Livre").append('\n');
            }
        }
        return lista.toString();
    }
}
