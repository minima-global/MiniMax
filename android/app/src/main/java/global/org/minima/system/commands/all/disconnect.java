package global.org.minima.system.commands.all;

import global.org.minima.system.Main;
import global.org.minima.system.commands.Command;
import global.org.minima.utils.json.JSONObject;

public class disconnect extends Command {

	public disconnect() {
		super("disconnect","[uid:uid] - Disconnect from a connected or connecting host");
	}
	
	@Override
	public JSONObject runCommand() throws Exception{
		JSONObject ret = getJSONReply();
		
		//Get the txpowid
		String uid = (String) getParams().get("uid");
		
		if(uid == null) {
			throw new Exception("No uid specified");
		}
		
		Main.getInstance().getNIOManager().disconnect(uid);
		
		ret.put("status", true);
		ret.put("message", "Attempting to disconnect from "+uid);
	
		return ret;
	}

	@Override
	public Command getFunction() {
		return new disconnect();
	}

}
