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
public class UserGiftBean {
    
    private String giftId;
    private String userId;
    private int bonusPoint;

    public UserGiftBean() {
    }

    public UserGiftBean(String giftId, String userId, int bonusPoint) {
        this.giftId = giftId;
        this.userId = userId;
        this.bonusPoint = bonusPoint;
    }

    public String getGiftId() {
        return giftId;
    }

    public void setGiftId(String giftId) {
        this.giftId = giftId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getBonusPoint() {
        return bonusPoint;
    }

    public void setBonusPoint(int bonusPoint) {
        this.bonusPoint = bonusPoint;
    }
    
    
}
