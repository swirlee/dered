package com.asjy.commerplat.service.Impl;

import java.util.List;

import com.asjy.commerplat.model.Address;

public interface IAddressService {

	int addAddress(Address address);

	List<Address> findAddressByUserid(Integer id);

	int deleteaddress(Integer id);

	Address findDefaultaddressByUserid(Integer userid);

	Address findAddressByid(Integer addressId);

	int updateAddress(Address address);

	void updateDefaultAddressToZero(Integer userid);

	int updateDefaultAddress(Integer addressid);

}
