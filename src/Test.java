import com.webjjang.board.dao.BoardDAO;
import com.webjjang.board.dao.BoardReplyDAO;

public class Test {

    public void pwreset() {

        BoardDAO dao1 = new BoardDAO();
        BoardReplyDAO dao2 = new BoardReplyDAO();

        dao1.resetPW();
        dao2.resetPW();

    }

    public static void main(String[] args) {

        Test t = new Test();

        t.pwreset();
    }

}