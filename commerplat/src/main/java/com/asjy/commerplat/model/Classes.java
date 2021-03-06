package com.asjy.commerplat.model;

import java.util.Date;
import java.util.List;

public class Classes {
    
    private Integer id;

    private Date addtime;

    private Boolean deletestate;

    private String classname;

    private Boolean display;

    private Integer pid;

    private Integer seq;
    
    private List<Classes> list_sonclasses;

   
    
   

	public List<Classes> getList_sonclasses() {
		return list_sonclasses;
	}

	public void setList_sonclasses(List<Classes> list_sonclasses) {
		this.list_sonclasses = list_sonclasses;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getAddtime() {
        return addtime;
    }

    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    public Boolean getDeletestate() {
        return deletestate;
    }

    public void setDeletestate(Boolean deletestate) {
        this.deletestate = deletestate;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname == null ? null : classname.trim();
    }

    public Boolean getDisplay() {
        return display;
    }

    public void setDisplay(Boolean display) {
        this.display = display;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }
    
    
}