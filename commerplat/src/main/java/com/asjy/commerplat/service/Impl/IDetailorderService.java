package com.asjy.commerplat.service.Impl;

import java.util.List;

import com.asjy.commerplat.model.Detailorder;

public interface IDetailorderService {

	int add(Detailorder detailorder);

	List<Detailorder> findByOrderid(Integer orderid);

}
