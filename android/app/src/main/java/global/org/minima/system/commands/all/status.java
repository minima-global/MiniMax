package global.org.minima.system.commands.all;

import java.io.File;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.util.Date;

import global.org.minima.database.MinimaDB;
import global.org.minima.database.archive.ArchiveManager;
import global.org.minima.database.cascade.Cascade;
import global.org.minima.database.txpowdb.TxPowDB;
import global.org.minima.database.txpowtree.TxPowTree;
import global.org.minima.database.wallet.Wallet;
import global.org.minima.objects.base.MiniData;
import global.org.minima.objects.base.MiniNumber;
import global.org.minima.system.Main;
import global.org.minima.system.brains.TxPoWGenerator;
import global.org.minima.system.commands.Command;
import global.org.minima.system.network.NetworkManager;
import global.org.minima.system.params.GeneralParams;
import global.org.minima.system.params.GlobalParams;
import global.org.minima.utils.Crypto;
import global.org.minima.utils.MiniFile;
import global.org.minima.utils.MiniFormat;
import global.org.minima.utils.NotReadyYetException;
import global.org.minima.utils.json.JSONObject;

public class status extends Command {

	public status() {
		super("status","(clean:true) - Show general status for Minima and Garbage collect RAM");
	}
	
	@Override
	public JSONObject runCommand() throws Exception{
		JSONObject ret = getJSONReply();
		
		//Are we clearing memory
		if(existsParam("clean")){
			System.gc();
		}

		//The Database
		TxPowDB txpdb 		= MinimaDB.getDB().getTxPoWDB();
		TxPowTree txptree 	= MinimaDB.getDB().getTxPoWTree();
		Cascade cascade		= MinimaDB.getDB().getCascade();
		ArchiveManager arch = MinimaDB.getDB().getArchive(); 
		Wallet wallet 		= MinimaDB.getDB().getWallet();

		//Do we haver any blocks..
		if(txptree.getTip() == null) {
			throw new NotReadyYetException("NO Blocks yet..");
		}


		JSONObject details = new JSONObject();
		details.put("version", GlobalParams.MINIMA_VERSION);

		//How many Devices..
		BigDecimal blkweightdec 	= new BigDecimal(txptree.getTip().getTxPoW().getBlockDifficulty().getDataValue());
		BigDecimal blockWeight 		= Crypto.MAX_VALDEC.divide(blkweightdec, MathContext.DECIMAL32);

		MiniNumber ratio 			= new MiniNumber(blockWeight).div(new MiniNumber(TxPoWGenerator.MIN_HASHES));
		MiniNumber pulsespeed 		= MiniNumber.THOUSAND.div(new MiniNumber(GeneralParams.USER_PULSE_FREQ));

		MiniNumber usersperpulse 	= MiniNumber.ONE.div(new MiniNumber(""+pulsespeed).div(GlobalParams.MINIMA_BLOCK_SPEED));
		MiniNumber totaldevs 		= usersperpulse.mult(ratio).floor();

		details.put("devices", totaldevs.getAsLong());

		//The Current total Length of the Minima Chain
		long totallength = txptree.getHeaviestBranchLength()+cascade.getLength();
		details.put("length", totallength);

		//The total weight of the chain + cascade
		BigInteger chainweight 	= txptree.getRoot().getTotalWeight().toBigInteger();
		BigInteger cascweight 	= MinimaDB.getDB().getCascade().getTotalWeight().toBigInteger();

		details.put("weight", chainweight.add(cascweight).toString());
		
		//Total Minima..
		MiniNumber minima = MinimaDB.getDB().getTxPoWTree().getTip().getTxPoW().getMMRTotal();
		details.put("global/org", minima);
		
		//How many coins..
		BigDecimal coins = MinimaDB.getDB().getTxPoWTree().getTip().getMMR().getEntryNumber().getBigDecimal();
		details.put("coins", coins);
		
		details.put("data", GeneralParams.DATA_FOLDER);
		
		JSONObject files = new JSONObject();

		//RAM usage
		long mem 		= Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
		String memused 	= MiniFormat.formatSize(mem);
		files.put("ram", memused);

		//File Memory
		long allfiles = MiniFile.getTotalFileSize(new File(GeneralParams.DATA_FOLDER));
		files.put("disk", MiniFormat.formatSize(allfiles));

		JSONObject database = new JSONObject();
		database.put("txpowdb", MiniFormat.formatSize(txpdb.getSqlFile().length()));
		database.put("archivedb", MiniFormat.formatSize(arch.getSQLFile().length()));
		database.put("cascade", MiniFormat.formatSize(MinimaDB.getDB().getCascadeFileSize()));
		database.put("chaintree", MiniFormat.formatSize(MinimaDB.getDB().getTxPowTreeFileSize()));
		database.put("wallet", MiniFormat.formatSize(wallet.getSQLFile().length()));
		database.put("userdb", MiniFormat.formatSize(MinimaDB.getDB().getUserDBFileSize()));
		database.put("p2pdb", MiniFormat.formatSize(MinimaDB.getDB().getP2PFileSize()));
		
		files.put("files", database);

		details.put("memory", files);
		
		//The main Chain
		JSONObject tree = new JSONObject();
		if(txptree.getRoot() != null) {
			tree.put("block", txptree.getTip().getTxPoW().getBlockNumber().getAsLong());
			tree.put("time", new Date(txptree.getTip().getTxPoW().getTimeMilli().getAsLong()).toString());
			tree.put("hash", txptree.getTip().getTxPoW().getTxPoWID());
			
			//Speed..
			if(txptree.getTip().getTxPoW().getBlockNumber().isLessEqual(MiniNumber.TWO)){
				tree.put("speed", 1);
			}else {
				MiniNumber blocksback = GlobalParams.MINIMA_BLOCKS_SPEED_CALC;
				if(txptree.getTip().getTxPoW().getBlockNumber().isLessEqual(GlobalParams.MINIMA_BLOCKS_SPEED_CALC)) {
					blocksback = txptree.getTip().getTxPoW().getBlockNumber().decrement();
				}
				tree.put("speed", TxPoWGenerator.getChainSpeed(txptree.getTip(),blocksback).setSignificantDigits(5));
			}
			
			MiniData difficulty = new MiniData(txptree.getTip().getTxPoW().getBlockDifficulty().getBytes(),32);
			tree.put("difficulty", difficulty.to0xString());

			tree.put("size", txptree.getSize());
			tree.put("length", txptree.getHeaviestBranchLength());
			tree.put("branches", txptree.getSize() - txptree.getHeaviestBranchLength());
			
			//Total weight..
			BigDecimal weighttree = txptree.getRoot().getTotalWeight();
			tree.put("weight", chainweight.toString());
			
		}else {
			tree.put("root", "0x00");
		}
		
		//The Cascade
		JSONObject casc = new JSONObject();
		if(cascade.getTip() != null) {
			casc.put("start", cascade.getTip().getTxPoW().getBlockNumber().getAsLong());
		}else {
			casc.put("start", -1);
		}
		casc.put("length", cascade.getLength());
		casc.put("weight", cascweight.toString());
		tree.put("cascade", casc);

		//Add the chain details
		details.put("chain", tree);

		//Add detailsl about the number of TxPoW we are tracking
		database = new JSONObject();
		database.put("mempool", txpdb.getAllUnusedTxns().size());
		database.put("ramdb", txpdb.getRamSize());
		database.put("txpowdb", txpdb.getSqlSize());
		database.put("archivedb", arch.getSize());

		//Add ther adatabse
		details.put("txpow", database);
		
		//Network..
		NetworkManager netmanager = Main.getInstance().getNetworkManager();
		if(netmanager!=null) {
			details.put("network", netmanager.getStatus());
		}
		
		//Add all the details
		ret.put("response", details);
		
		return ret;
	}

	@Override
	public Command getFunction() {
		return new status();
	}

}
