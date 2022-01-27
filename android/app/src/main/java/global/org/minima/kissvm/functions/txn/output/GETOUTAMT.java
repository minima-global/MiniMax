package global.org.minima.kissvm.functions.txn.output;

import java.util.ArrayList;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.functions.MinimaFunction;
import global.org.minima.kissvm.values.NumberValue;
import global.org.minima.kissvm.values.Value;
import global.org.minima.objects.Coin;
import global.org.minima.objects.Token;
import global.org.minima.objects.Transaction;

public class GETOUTAMT extends MinimaFunction {

	public GETOUTAMT() {
		super("GETOUTAMT");
	}
	
	@Override
	public Value runFunction(Contract zContract) throws ExecutionException {
		checkExactParamNumber(requiredParams());
		
		//Which Output - must be from 0-255
		int output = zContract.getNumberParam(0, this).getNumber().getAsInt();
		
		//Get the Transaction
		Transaction trans = zContract.getTransaction();
		
		//Check output exists..
		ArrayList<Coin> outs = trans.getAllOutputs();
		if(output<0 || outs.size()<=output) {
			throw new ExecutionException("Output out of range "+output+"/"+outs.size());
		}
		
		//Get it..
		Coin cc = outs.get(output);
		
		//Is it a Token..
		if(!cc.getTokenID().isEqual(Token.TOKENID_MINIMA)) {
			//Get the Multiple..
			Token td = cc.getToken();
			if(td == null) {
				throw new ExecutionException("No Token for Output Coin @ "+output+" "+cc.getToken());
			}
			
			//Return the scaled amount
			return new NumberValue(td.getScaledTokenAmount(cc.getAmount()));
		}
		
		//Return the Amount
		return new NumberValue(cc.getAmount());
	}

	@Override
	public int requiredParams() {
		return 1;
	}
	
	@Override
	public MinimaFunction getNewFunction() {
		return new GETOUTAMT();
	}
}
