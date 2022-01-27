package global.org.minima.system.commands.all;

import global.org.minima.database.MinimaDB;
import global.org.minima.database.mmr.MMR;
import global.org.minima.system.commands.Command;
import global.org.minima.utils.json.JSONObject;

public class printmmr extends Command {

	public printmmr() {
		super("printmmr", "");
	}
	
	@Override
	public JSONObject runCommand() throws Exception {
		JSONObject ret = getJSONReply();
		
		MMR mmr = MinimaDB.getDB().getTxPoWTree().getTip().getMMR();
		
		ret.put("responsse", mmr.toJSON());
		return ret;
	}

	@Override
	public Command getFunction() {
		return new printmmr();
	}

}
