package entity;

public class User {
    private Integer userId;      //用户编号
    private String userName;     //用户昵称
    private String passWord;     //密码
    private Integer gender;      //性别（女 ；0  男 ；1）
    private String phone;        //手机号
    private Integer userRole;    //用户类别（普通用户 ；1  会员 ；2）
    private String signature;    //个性签名
    private String headPic;      //头像
    private String contribution; //投稿
    private Integer fans;        //粉丝数量
    private Integer concern;     //关注数量
    private String birthday;     //生日
    private String notice;       //个人中心的公告

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getNotice() {
        return notice;
    }

    public void setNotice(String notice) {
        this.notice = notice;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getUserRole() {
        return userRole;
    }

    public void setUserRole(Integer userRole) {
        this.userRole = userRole;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getHeadPic() {
        return headPic;
    }

    public void setHeadPic(String headPic) {
        this.headPic = headPic;
    }

    public String getContribution() {
        return contribution;
    }

    public void setContribution(String cintribution) {
        this.contribution = cintribution;
    }

    public Integer getFans() {
        return fans;
    }

    public void setFans(Integer fans) {
        this.fans = fans;
    }

    public Integer getConcern() {
        return concern;
    }

    public void setConcern(Integer concern) {
        this.concern = concern;
    }


}
