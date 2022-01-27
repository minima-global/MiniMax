package global.org.minima.system.commands.all;

import global.org.minima.system.commands.Command;
import global.org.minima.utils.json.JSONObject;

public class missingcmd extends Command {

	String mInput;
	String mError;
	
	public missingcmd(String zInput, String zError) {
		super("missingcmd","");
		mInput = zInput;
		mError = zError;
	}
	
	@Override
	public JSONObject runCommand() throws Exception {
		JSONObject result = getJSONReply();
		result.put("command", mInput);
		result.put("status", false);
		result.put("error", mError);
		return result;
	}

	@Override
	public Command getFunction() {
		return new missingcmd("","");
	}

}
