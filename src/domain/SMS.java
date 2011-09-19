package domain;

public class SMS {
	
	protected int smsID;
	protected String smsSender;
	protected String smsReceiver;
	protected String smsMessage;
	protected String smsSentTime;
	protected String smsReceivedTime;
	protected String smsOperator;
	protected String smsMsgType;
	protected String smsPreference;
	protected String smsStatus;
	protected String smsErrorMsg;
	public int getSmsID() {
		return smsID;
	}
	public void setSmsID(int smsID) {
		this.smsID = smsID;
	}
	public String getSmsSender() {
		return smsSender;
	}
	public void setSmsSender(String smsSender) {
		this.smsSender = smsSender;
	}
	public String getSmsReceiver() {
		return smsReceiver;
	}
	public void setSmsReceiver(String smsReceiver) {
		this.smsReceiver = smsReceiver;
	}
	public String getSmsMessage() {
		return smsMessage;
	}
	public void setSmsMessage(String smsMessage) {
		this.smsMessage = smsMessage;
	}
	public String getSmsSentTime() {
		return smsSentTime;
	}
	public void setSmsSentTime(String smsSentTime) {
		this.smsSentTime = smsSentTime;
	}
	public String getSmsReceivedTime() {
		return smsReceivedTime;
	}
	public void setSmsReceivedTime(String smsReceivedTime) {
		this.smsReceivedTime = smsReceivedTime;
	}
	public String getSmsOperator() {
		return smsOperator;
	}
	public void setSmsOperator(String smsOperator) {
		this.smsOperator = smsOperator;
	}
	public String getSmsMsgType() {
		return smsMsgType;
	}
	public void setSmsMsgType(String smsMsgType) {
		this.smsMsgType = smsMsgType;
	}
	public String getSmsPreference() {
		return smsPreference;
	}
	public void setSmsPreference(String smsPreference) {
		this.smsPreference = smsPreference;
	}
	public String getSmsStatus() {
		return smsStatus;
	}
	public void setSmsStatus(String smsStatus) {
		this.smsStatus = smsStatus;
	}
	public String getSmsErrorMsg() {
		return smsErrorMsg;
	}
	public void setSmsErrorMsg(String smsErrorMsg) {
		this.smsErrorMsg = smsErrorMsg;
	}
	
}
