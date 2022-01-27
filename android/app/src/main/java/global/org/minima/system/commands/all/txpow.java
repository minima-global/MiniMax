package global.org.minima.system.commands.all;

import global.org.minima.database.MinimaDB;
import global.org.minima.objects.TxPoW;
import global.org.minima.system.commands.Command;
import global.org.minima.utils.json.JSONObject;

public class txpow extends Command {

	public txpow() {
		super("txpow","[txpowid:txpowid] - Search for a specific TxPoW");
	}
	
	@Override
	public JSONObject runCommand() throws Exception{
		JSONObject ret = getJSONReply();
		
		//Get the txpowid
		if(!existsParam("txpowid")) {
			throw new Exception("No txpowid parameter specified");
		}
		
		String txpowid = getParam("txpowid", "0x01");
		
		//Search for a given txpow
		TxPoW txpow = MinimaDB.getDB().getTxPoWDB().getTxPoW(txpowid);
		if(txpow == null) {
			throw new Exception("TxPoW not found : "+txpowid);
		}
		
		ret.put("status", true);
		ret.put("response", txpow.toJSON());
	
		return ret;
	}

	@Override
	public Command getFunction() {
		return new txpow();
	}

}
