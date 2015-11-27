/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.bean;

import java.sql.Date;

/**
 *
 * @author pet10_000
 */
public class OrderBean {
    
    private String oId;
    private String uId;
    private Date pickUpDate;
    private double tPrice;
    private String status;
    private int bonus;

    public OrderBean() {
    }

    public OrderBean(String oId, String uId, Date pickUpDate, double tPrice, String status, int bonus) {
        this.oId = oId;
        this.uId = uId;
        this.pickUpDate = pickUpDate;
        this.tPrice = tPrice;
        this.status = status;
        this.bonus = bonus;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getBonus() {
        return bonus;
    }

    public void setBonus(int bonus) {
        this.bonus = bonus;
    }

    public Date getPickUpDate() {
        return pickUpDate;
    }

    public void setPickUpDate(Date pickUpDate) {
        this.pickUpDate = pickUpDate;
    }
    
}
