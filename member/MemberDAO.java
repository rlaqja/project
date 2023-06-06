package com.multi.gazee.member;

import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.multi.gazee.order.OrderVO;
import com.multi.gazee.productLikes.ProductLikesVO;

@Component
public class MemberDAO { // CRUD
	
	@Autowired
	SqlSessionTemplate gazee;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber;
	
	public MemberVO login(String id) {
		MemberVO result = gazee.selectOne("member.login", id);
		return result;
	}
	
	public MemberVO logincheck(String id) {
		MemberVO result = gazee.selectOne("member.logincheck", id);
		return result;
	}
	
	public void insert(MemberVO bag) {
		if (bag.getGender().equals("female")) {
			bag.setGender("여성");
		} else {
			bag.setGender("남성");
		}
		System.out.println(bag);
		gazee.insert("member.create", bag);
	}
	
	public MemberVO idCheck(String id) {
		MemberVO vo = gazee.selectOne("member.searchOne", id);
		return vo;
	}

	public MemberVO nicknameCheck(String id) {
		MemberVO vo = gazee.selectOne("member.nickOne", id);
		return vo;
	}
	
	public MemberVO selectOne(String id) {
		MemberVO bag = gazee.selectOne("member.searchOne", id);
		return bag;
	}
	
	public MemberVO emailCheck(String email) {
		MemberVO vo = gazee.selectOne("member.emailCheck", email);
		return vo;
	}
	
	public void makeRandomNumber() {
		// 난수의 범위 111111 ~ 999999 (6자리 난수)
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}
	
	// 이메일 보낼 양식!
	public String joinEmail(String email) {
		makeRandomNumber();
		String setFrom = ".com"; // email-config에 설정한 자신의 이메일 주소를 입력
		String toMail = email;
		String title = "회원 가입 인증 이메일 입니다."; // 이메일 제목
		String content = "홈페이지를 방문해주셔서 감사합니다." + // html 형식으로 작성 !
				"<br><br>" + "인증 번호는 " + authNumber + "입니다." + "<br>" + "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; // 이메일 내용 삽입
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}
	
	// 이메일 전송 메소드
	public void mailSend(String setFrom, String toMail, String title, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		// true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			// true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
			helper.setText(content, true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	public void leave(MemberVO bag) {
		gazee.update("member.leave", bag);
	}

	public void nick(MemberVO bag) {
		gazee.update("member.nick", bag);
	}
	
	public void updatePw(MemberVO bag) {
		gazee.update("member.updatePw", bag);
	}
	
	public String getId(String email) {
		MemberVO memberVO = gazee.selectOne("member.emailCheck", email);
		String id = memberVO.getId();
		return id;
	}
	
	public MemberVO findPw(String id) {
		MemberVO vo = gazee.selectOne("member.searchOne", id);
		return vo;
	}
	
	public void updateuser(MemberVO bag) {
		gazee.update("member.updateuser", bag);
	}
	
	public void profileImg(MemberVO bag) {
		gazee.update("member.profileImg", bag);
	}
	
	public void trackingNo(OrderVO bag) {
		if (bag.getDeliveryCom().equals("HanJin")) {
			bag.setDeliveryCom("한진택배");
		} else if (bag.getDeliveryCom().equals("CJ")) {
			bag.setDeliveryCom("CJ대한통운");
		} else {
			bag.setDeliveryCom("로젠택배");
		}
		gazee.update("member.trackingNo", bag);
	}
	
	public void buyerCon(MemberVO bag) {
		gazee.update("member.buyerCon", bag);
	}
	
	public void logoutTimeUpdate(String id) {
		gazee.update("member.logoutTimeUpdate", id);
	}
	
	public List<OrderVO> purchsList(String id) {
		List<OrderVO> list = gazee.selectList("member.purchsList", id);
		System.out.println("DAO" + list.size());
		return list;
	}

	public List<OrderVO> sellList(String id) {
		List<OrderVO> list = gazee.selectList("member.sellList", id);
		System.out.println("DAO" + list.size());
		return list;
	}

	public List<ProductLikesVO> basketList(String id) {
		List<ProductLikesVO> list = gazee.selectList("member.basketList", id);
		System.out.println("DAO" + list.size());
		return list;
	}
}
