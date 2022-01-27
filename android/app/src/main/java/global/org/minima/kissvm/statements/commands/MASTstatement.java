package global.org.minima.kissvm.statements.commands;

import java.util.List;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.expressions.Expression;
import global.org.minima.kissvm.statements.Statement;
import global.org.minima.kissvm.statements.StatementBlock;
import global.org.minima.kissvm.statements.StatementParser;
import global.org.minima.kissvm.tokens.ScriptToken;
import global.org.minima.kissvm.tokens.ScriptTokenizer;
import global.org.minima.kissvm.values.HexValue;
import global.org.minima.objects.ScriptProof;
import global.org.minima.objects.Witness;

public class MASTstatement implements Statement {

	/**
	 * The MAST script is a HEXvalue that is the hash of the script..
	 */
	Expression mMASTScript;
	
	public MASTstatement(Expression zMAST) {
		mMASTScript = zMAST;
	}
	
	@Override
	public void execute(Contract zContract) throws ExecutionException {
		//get the MAST Value..
		HexValue mast = (HexValue) mMASTScript.getValue(zContract);
		
		//Now get that Script from the transaction..
		Witness wit = zContract.getWitness();
		
		//Get the Script Proof
		ScriptProof scrpr = wit.getScript(mast.getMiniData());
		
		if(scrpr == null) {
			throw new ExecutionException("No script found for MAST "+mast.getMiniData());
		}
		
		//get the script of this hash value
		String script = scrpr.getScript().toString();
		
		try {
			//Tokenize the script
			ScriptTokenizer tokz = new ScriptTokenizer(script.toString());
			
			//Convert the script to KISSVM!
			List<ScriptToken> tokens = tokz.tokenize();	
		
			//And now convert to a statement block..
			StatementBlock mBlock = StatementParser.parseTokens(tokens);

			//Now run it..
			mBlock.run(zContract);
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new ExecutionException(e.toString());
		}		
	}

	@Override
	public String toString() {
		return "MAST "+mMASTScript.toString();
	}
}
