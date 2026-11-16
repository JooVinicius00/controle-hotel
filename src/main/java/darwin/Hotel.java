package darwin;

import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

public class Hotel {
    private static Integer numero(String mensagem) {
        String valor = JOptionPane.showInputDialog(mensagem);
        return valor == null ? null : Integer.valueOf(valor.trim());
    }
    public static void main(String[] args) {
        OcupacaoHotel hotel = new OcupacaoHotel();
        while (true) {
            try {
                Integer opcao = numero("HOTEL\n1 - Listar quartos\n2 - Definir ocupação\n0 - Sair");
                if (opcao == null || opcao == 0) return;
                if (opcao == 1) {
                    JTextArea lista = new JTextArea(hotel.listar(), 26, 28);
                    lista.setEditable(false);
                    JOptionPane.showMessageDialog(null, new JScrollPane(lista), "Quartos", JOptionPane.INFORMATION_MESSAGE);
                } else if (opcao == 2) {
                    Integer andar = numero("Andar (1 a 5):");
                    if (andar == null) continue;
                    Integer quarto = numero("Quarto (1 a 5):");
                    if (quarto == null) continue;
                    Integer estado = numero("1 - Ocupado\n2 - Livre");
                    if (estado == null) continue;
                    if (estado != 1 && estado != 2) throw new IllegalArgumentException("Escolha 1 ou 2.");
                    hotel.definir(andar, quarto, estado == 1);
                    JOptionPane.showMessageDialog(null, "Ocupação atualizada.");
                } else {
                    throw new IllegalArgumentException("Opção inválida.");
                }
            } catch (IllegalArgumentException erro) {
                JOptionPane.showMessageDialog(null, "Entrada inválida. " + erro.getMessage());
            }
        }
    }
}
