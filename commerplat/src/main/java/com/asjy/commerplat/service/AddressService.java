package com.asjy.commerplat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.AddressMapper;
import com.asjy.commerplat.model.Address;
import com.asjy.commerplat.service.Impl.IAddressService;

@Service
public class AddressService implements IAddressService {
	
	@Autowired
	AddressMapper adderMapper;
	
	/**
	 * 添加新地址
	 */
	@Override
	public int addAddress(Address address) {
		return adderMapper.insertSelective(address);
	}

	@Override
	public List<Address> findAddressByUserid(Integer userid) {
		
		return adderMapper.selectByUserid(userid);
	}

	@Override
	public int deleteaddress(Integer id) {
		
		return adderMapper.deleteByPrimaryKey(id);
	}

	@Override
	public Address findDefaultaddressByUserid(Integer userid) {
		List<Address> list_address = adderMapper.selectByUserid(userid);
		Address address = adderMapper.findDefaultaddressByUserid(userid);
		if(list_address != null && list_address.size() > 0) {
			if(address!=null) {
				return address;
			}else {
				return list_address.get(0);
			}
		}else {
			return null;
		}
	}

	@Override
	public Address findAddressByid(Integer addressId) {
		
		return adderMapper.selectByaddressid(addressId);
	}

	@Override
	public int updateAddress(Address address) {
		
		return adderMapper.updateByPrimaryKeySelective(address);
	}

	@Override
	public void updateDefaultAddressToZero(Integer userid) {
		adderMapper.updateDefaultAddressToZero(userid);
	}

	@Override
	public int updateDefaultAddress(Integer addressid) {
		return adderMapper.updateDefaultAddress(addressid);
	}
	
}
