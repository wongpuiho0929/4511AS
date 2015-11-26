/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

/**
 *
 * @author pet10_000
 */
public class OrderBean {
    
    private String oId;
    private String uId;
    private double tPrice;

    public OrderBean() {
    }

    public OrderBean(String oId, String uId, double tPrice) {
        this.oId = oId;
        this.uId = uId;
        this.tPrice = tPrice;
    }

    public String getoId() {
        return oId;
    }

    public void setoId(String oId) {
        this.oId = oId;
    }

    public String getuId() {
        return uId;
    }

    public void setuId(String uId) {
        this.uId = uId;
    }

    public double gettPrice() {
        return tPrice;
    }

    public void settPrice(double tPrice) {
        this.tPrice = tPrice;
    }
    
}
