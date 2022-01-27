package global.org.minima.system.commands.all;

import global.org.minima.objects.base.MiniString;
import global.org.minima.system.Main;
import global.org.minima.system.commands.Command;
import global.org.minima.system.network.minima.NIOMessage;
import global.org.minima.utils.json.JSONObject;

public class message extends Command {

	public message() {
		super("message","(uid:uid) [data:message] - Send a message over the network to your peers");
	}
	
	@Override
	public JSONObject runCommand() throws Exception{
		JSONObject ret = getJSONReply();
		
		//get the data
		String data = (String) getParams().get("data");
		if(data == null) {
			throw new Exception("No data specified");
		}
		
		//Is there a UID
		String uid = (String) getParams().get("uid");
		if(uid == null) {
			uid = "";
			ret.put("message", "Message sent to all");
		}else {
			ret.put("message", "Message sent to "+uid);
		}
		
		//Create a message..
		MiniString msg 	= new MiniString(data);
		
		//Send it..
		Main.getInstance().getNIOManager().sendNetworkMessage(uid, NIOMessage.MSG_GENMESSAGE, msg);
			
		return ret;
	}

	@Override
	public Command getFunction() {
		return new message();
	}

}
