package global.org.minima.kissvm.functions.txn.input;

import java.util.ArrayList;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.HexValue;
import global.org.minima.kissvm.values.Value;
import global.org.minima.objects.Coin;
import global.org.minima.objects.Transaction;

public class GETINTOK extends MinimaFunction {

	public GETINTOK() {
		super("GETINTOK");
	}
	
	@Override
	public Value runFunction(Contract zContract) throws ExecutionException {
		checkExactParamNumber(requiredParams());
		
		//Which Output
		int input = zContract.getNumberParam(0, this).getNumber().getAsInt();
				
		//Get the Transaction
		Transaction trans = zContract.getTransaction();
		
		//Check output exists..
		ArrayList<Coin> ins = trans.getAllInputs();
		if(input<0 || ins.size()<=input) {
			throw new ExecutionException("Input number out of range "+input+"/"+ins.size());
		}
		
		//Get it..
		Coin cc = ins.get(input);
		
		//Return the address	
		return new HexValue(cc.getTokenID());
	}

	@Override
	public int requiredParams() {
		return 1;
	}
	
	@Override
	public MinimaFunction getNewFunction() {
		return new GETINTOK();
	}
}
