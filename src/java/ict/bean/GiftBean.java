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
public class GiftBean {
    
    private String giftId;
    private String giftName;
    private int bonusPoint;
    private int qty;
    private String descriptions;

    public GiftBean() {
    }

    public GiftBean(String giftId, String giftName, int bonusPoint, int qty, String descriptions) {
        this.giftId = giftId;
        this.giftName = giftName;
        this.bonusPoint = bonusPoint;
        this.qty = qty;
        this.descriptions = descriptions;
    }

    public String getGiftId() {
        return giftId;
    }

    public void setGiftId(String giftId) {
        this.giftId = giftId;
    }

    public String getGiftName() {
        return giftName;
    }

    public void setGiftName(String giftName) {
        this.giftName = giftName;
    }

    public int getBonusPoint() {
        return bonusPoint;
    }

    public void setBonusPoint(int bonusPoint) {
        this.bonusPoint = bonusPoint;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(String descriptions) {
        this.descriptions = descriptions;
    }
       
}
