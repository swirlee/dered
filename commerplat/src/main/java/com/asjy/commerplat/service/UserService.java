package com.asjy.commerplat.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.UserMapper;
import com.asjy.commerplat.exception.SystemException;
import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.Impl.IUserService;
import com.asjy.commerplat.util.Message;

@Service
public class UserService implements IUserService {
	
	@Autowired
	UserMapper usermapper;
	
	@Autowired
	Message message;
	
	@Override
	public List<User> findAll() {
//		String username = null;
//		if(username == null) {
//			throw new SystemException("名字为空值");
//		}else {
//			return usermapper.findAll();
//		}
		return usermapper.findAll();
	}

	@Override
	public int adduser(String username, String password, String phone, String email, String realname, String sex,
			Boolean authority, Date addtime) {
		
		if(username == null) {
			throw new SystemException("用户名为空值，请重新输入（后）");
			//throw new SystemException(message.MI01);
		}
		if(password == null) {
			throw new SystemException("密码为空值，请重新输入（后）");
			//throw new SystemException(message.MI01);
		}
		if(phone == null) {
			throw new SystemException("电话号码为空值，请重新输入（后）");
			//throw new SystemException(message.MI01);
		}
		if(email == null) {
			throw new SystemException("邮箱号码为空值，请重新输入（后）");
			//throw new SystemException(message.MI01);
		}
		if(sex == null) {
			throw new SystemException("性别为空值，请重新输入（后）");
			//throw new SystemException(message.MI01);
		}
		
		
		return usermapper.insert(username, password, phone, email, realname, sex, authority,addtime);
		
		
	}


	@Override
	public User findbyid(int id) {
		
		return usermapper.findbyid(id);
	}

	@Override
	public User findbyusernameandpassword(String username, String password) {
		
		return usermapper.findbyusernameandpassword(username, password);
	}

	@Override
	public Boolean findByValidate(String validate, String ziduan) {
		
		User user = usermapper.findByValidate(validate, ziduan);
		if(user != null) {
			return false;
		}else {
			return true;
		}
	}

	@Override
	public int addNewUser(User user) {
		return usermapper.insertSelective(user);
	}
	
	/**
	 * 个人中心-ajax修改用户密码
	 */
	@Override
	public Boolean updatePassword(Map<String, Object> map, HttpSession session) {
		String oldPassword = (String)map.get("old_password");
		String newPassword = (String)map.get("new_password");
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		User user = usermapper.findbyid(userid);
		if(oldPassword != "" && user.getPassword().equals(oldPassword)){
			user.setPassword(newPassword);
			usermapper.updateByPrimaryKeySelective(user);
			return true;
		}else if(oldPassword != "" && !user.getPassword().equals(oldPassword)){
			return false;
		}else {
			return null;
		}
	}
	
	/**
	 * validate判断邮箱是否已经被其他人绑定
	 */
	@Override
	public Boolean findByUserAndValidate(String validate, String ziduan, HttpSession session) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		User user1 = usermapper.findbyid(userid);
		User user = usermapper.findByValidate(validate, ziduan);
		if(ziduan.equals("email")) {
			if(user1.getEmail().equals(validate)) {
				return true;
			}else if(!user1.getEmail().equals(validate) && user==null) {
				return true;
			}else {
				return false;
			}
		}
		if(ziduan.equals("username")) {
			if(user1.getUsername().equals(validate)) {
				return true;
			}else if(!user1.getUsername().equals(validate) && user==null) {
				return true;
			}else {
				return false;
			}
		}
		return null;
	}

	/**
	 * 个人中心-ajax修改用户email
	 */
	@Override
	public Boolean updateemail(Map<String, Object> map, HttpSession session) {
		String password = (String)map.get("password");
		String email = (String)map.get("email");
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		User user = usermapper.findbyid(userid);
		//查询email是否被别人注册//elseuse代表用户输入的邮箱号已经被注册的人
		User elseuse = usermapper.findByValidate(email, "email");
		
		if(password != "" && user.getPassword().equals(password)){
			if(elseuse==null) {
				user.setEmail(email);
				usermapper.updateByPrimaryKeySelective(user);
				return true;
			}else {
				return false;
			}
		}else if(password != "" && !user.getPassword().equals(password)){
			return false;
		}else {
			return null;
		}
	}

	@Override
	public Boolean updatedetail(Map<String, Object> map, HttpSession session) {
		String username = (String)map.get("username");
		String realname = (String)map.get("realname");
		String sex = (String)map.get("sex");
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		User user = usermapper.findbyid(userid);
		//查询email是否被别人注册//elseuse代表用户输入的邮箱号已经被注册的人
		User elseuse = usermapper.findByValidate(username, "username");
			if(elseuse==null ||elseuse.getId()==userid) {
				user.setUsername(username);
				user.setRealname(realname);
				user.setSex(sex);
				usermapper.updateByPrimaryKeySelective(user);
				return true;
			}else {
				return false;
			}
		
	}

	@Override
	public int updateUser(User user) {
		return usermapper.updateByPrimaryKeySelective(user);
	}

}
