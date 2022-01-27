package global.org.minima.system.genesis;

import java.util.ArrayList;

import global.org.minima.database.mmr.MMRData;
import global.org.minima.database.mmr.MMREntryNumber;
import global.org.minima.database.mmr.MMRProof;
import global.org.minima.database.txpowtree.TxPoWTreeNode;
import global.org.minima.objects.Address;
import global.org.minima.objects.Coin;
import global.org.minima.objects.CoinProof;
import global.org.minima.objects.ScriptProof;
import global.org.minima.objects.Token;
import global.org.minima.objects.Transaction;
import global.org.minima.objects.TxBlock;
import global.org.minima.objects.TxPoW;
import global.org.minima.objects.Witness;
import global.org.minima.objects.base.MiniData;
import global.org.minima.objects.base.MiniNumber;
import global.org.minima.system.params.GlobalParams;
import global.org.minima.utils.Crypto;
import global.org.minima.utils.MinimaLogger;

public class GenesisTxPoW extends TxPoW {

	public GenesisTxPoW(String zGenesisAddress) {
		super();
		
		//The first BASE MMR..
		GenesisMMR genesismmr = new GenesisMMR();
		
		setTxDifficulty(Crypto.MAX_HASH);
		
		setNonce(new MiniNumber(256));
		 
		setTimeMilli(new MiniNumber(System.currentTimeMillis()));
		
		//First Block starts at 1! .. 0 created the genesis coin
		setBlockNumber(MiniNumber.ONE);
		
		setBlockDifficulty(Crypto.MAX_HASH);
		
		//Super Block Levels.. FIRST just copy them all..
		MiniData ultimateparent = new MiniData("0x00");
		for(int i=0;i<GlobalParams.MINIMA_CASCADE_LEVELS;i++) {
			setSuperParent(i, ultimateparent);
		}
		
		//Set the Genesis transaction
		Transaction transaction = getTransaction();
		
		//The first billion Minima
		transaction.addInput(new GenesisCoin());
		
		//Now add 1 output
		Coin minima = new Coin(	Coin.COINID_OUTPUT, 
								new MiniData(zGenesisAddress), 
								MiniNumber.BILLION, 
								Token.TOKENID_MINIMA);
		transaction.addOutput(minima);
		
		//Add a coinproof..
		Witness witness = getWitness();
		
		//Get the proof..
		MMRProof proof = genesismmr.getProofToPeak(MMREntryNumber.ZERO);
		
		//Create the CoinProof..
		CoinProof cp = new CoinProof(new GenesisCoin(), proof);
		
		//Add it to the witness data
		witness.addCoinProof(cp);
		
		//And the script is Return True..
		witness.addScript(new ScriptProof(Address.TRUE_ADDRESS.getScript()));
		
		//Set the body hash - no more changes..
		setHeaderBodyHash();
		
		//Calculate the TxPOWID
		calculateTransactionID();
		
		//Create a TxBlock..
		TxBlock txblock 	= new TxBlock(genesismmr, this, new ArrayList<>());
		
		//And the MMR details
		TxPoWTreeNode node 	= new TxPoWTreeNode(txblock, false);
		
		//Get the MMR root data
		MMRData root = node.getMMR().getRoot();
		setMMRRoot(root.getData());
		setMMRTotal(root.getValue());
		
		//Set the TXPOW
		calculateTXPOWID();
		
		//Get the TxPoWID - this is a one time universal value
		String gentxpow = getTxPoWID();
		MinimaLogger.log("Genesis block created : "+gentxpow);
		
		//Hard code it..
		_mIsBlockPOW = true;
		_mIsTxnPOW   = true;
	}
	
}
