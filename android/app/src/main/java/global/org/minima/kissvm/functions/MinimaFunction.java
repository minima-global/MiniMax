/**
 * 
 */
package global.org.minima.kissvm.functions;

import java.util.ArrayList;

import global.org.minima.kissvm.Contract;
import global.org.minima.kissvm.exceptions.ExecutionException;
import global.org.minima.kissvm.exceptions.MinimaParseException;
import global.org.minima.kissvm.expressions.Expression;
import global.org.minima.kissvm.functions.cast.BOOL;
import global.org.minima.kissvm.functions.cast.HEX;
import global.org.minima.kissvm.functions.cast.NUMBER;
import global.org.minima.kissvm.functions.cast.STRING;
import global.org.minima.kissvm.functions.general.GET;
import global.org.minima.kissvm.functions.hex.BITCOUNT;
import global.org.minima.kissvm.functions.hex.BITGET;
import global.org.minima.kissvm.functions.hex.BITSET;
import global.org.minima.kissvm.functions.hex.CONCAT;
import global.org.minima.kissvm.functions.hex.LEN;
import global.org.minima.kissvm.functions.hex.REV;
import global.org.minima.kissvm.functions.hex.SUBSET;
import global.org.minima.kissvm.functions.number.ABS;
import global.org.minima.kissvm.functions.number.CEIL;
import global.org.minima.kissvm.functions.number.DEC;
import global.org.minima.kissvm.functions.number.FLOOR;
import global.org.minima.kissvm.functions.number.INC;
import global.org.minima.kissvm.functions.number.MAX;
import global.org.minima.kissvm.functions.number.MIN;
import global.org.minima.kissvm.functions.number.POW;
import global.org.minima.kissvm.functions.number.SIGDIG;
import global.org.minima.kissvm.functions.sha.KECCAK;
import global.org.minima.kissvm.functions.sha.PROOF;
import global.org.minima.kissvm.functions.sha.SHA2;
import global.org.minima.kissvm.functions.sigs.CHECKSIG;
import global.org.minima.kissvm.functions.sigs.MULTISIG;
import global.org.minima.kissvm.functions.sigs.SIGNEDBY;
import global.org.minima.kissvm.functions.state.PREVSTATE;
import global.org.minima.kissvm.functions.state.SAMESTATE;
import global.org.minima.kissvm.functions.state.STATE;
import global.org.minima.kissvm.functions.string.REPLACE;
import global.org.minima.kissvm.functions.string.SUBSTR;
import global.org.minima.kissvm.functions.string.UTF8;
import global.org.minima.kissvm.functions.txn.input.GETINADDR;
import global.org.minima.kissvm.functions.txn.input.GETINAMT;
import global.org.minima.kissvm.functions.txn.input.GETINID;
import global.org.minima.kissvm.functions.txn.input.GETINTOK;
import global.org.minima.kissvm.functions.txn.input.VERIFYIN;
import global.org.minima.kissvm.functions.txn.output.GETOUTADDR;
import global.org.minima.kissvm.functions.txn.output.GETOUTAMT;
import global.org.minima.kissvm.functions.txn.output.GETOUTTOK;
import global.org.minima.kissvm.functions.txn.output.VERIFYOUT;
import global.org.minima.kissvm.values.Value;

/**
 * @author Spartacus Rex
 *
 */
public abstract class MinimaFunction {
	
	/**
	 * A list of all the available functions
	 */
	public static MinimaFunction[] ALL_FUNCTIONS = 
			{ 
				new CONCAT(), new LEN(), new REV(),new SUBSET(), new GET(),
				new BOOL(), new HEX(), new NUMBER(), new STRING(),
				new ABS(), new CEIL(), new FLOOR(),new MAX(), new MIN(), new DEC(), new INC(), 
				new SIGDIG(), new POW(), 
				new REPLACE(), new SUBSTR(), new UTF8(),
				new KECCAK(), new SHA2(), new PROOF(), new BITSET(), new BITGET(), new BITCOUNT(),
				new SIGNEDBY(), new MULTISIG(), new CHECKSIG(),
				new GETINADDR(), new GETINAMT(), new GETINID(), new GETINTOK(),new VERIFYIN(),
				new GETOUTADDR(), new GETOUTAMT(), new GETOUTTOK(),new VERIFYOUT(),
				new STATE(), new PREVSTATE(), new SAMESTATE()
			};
	
	/**
	 * The name used to refer to this function in RamScript. 
	 */
	private String mName;
	
	/**
	 * The Parameters
	 */
	ArrayList<Expression> mParameters;
	
	/**
	 * 
	 */
	public MinimaFunction(String zName) {
		//Function names are always Uppercase
		mName = zName.toUpperCase();
		
		//Blank the parameters
		mParameters = new ArrayList<>();
	}
	
	public void addParameter(Expression zParam) {
		mParameters.add(zParam);
	}
	
	public Expression getParameter(int zParamNum) throws ExecutionException {
		if(zParamNum>=getParameterNum()) {
			throw new ExecutionException("Parameter missing for "+getName()+" num:"+zParamNum);
		}
		return mParameters.get(zParamNum);
	}
	
	public int getParameterNum(){
		return mParameters.size();
	}
	
	public ArrayList<Expression> getAllParameters(){
		return mParameters;
	}
	
	public String getName() {
		return mName;
	}
	
	/**
	 * Check all parameters are of the Type required
	 * 
	 * @param zType
	 * @param zContract
	 * @param zParams
	 * @throws ExecutionException 
	 */
	protected void checkAllParamsType(int zType, Contract zContract) throws ExecutionException {
		int count=0;
		for(Expression exp : getAllParameters()) {
			Value vv = exp.getValue(zContract);
			if(vv.getValueType() != zType) {
				throw new ExecutionException("Incorrect type in parameters @ "+count
						+". Found "+Value.getValueTypeString(vv.getValueType())
						+" expected "+Value.getValueTypeString(zType));
			}
			count++;
		}
	}
	
	protected void checkIsOfType(Value zValue, int zType) throws ExecutionException {
		if((zValue.getValueType() & zType) == 0) {
			throw new ExecutionException("Parameter is incorrect type in "+getName()+". Found "+Value.getValueTypeString(zValue.getValueType()));
		}
	}
	
	protected void checkExactParamNumber(int zNumberOfParams) throws ExecutionException {
		if(getAllParameters().size() != zNumberOfParams) {
			throw new ExecutionException("Function requires "+zNumberOfParams+" parameters");
		}
	}
	
	protected void checkMinParamNumber(int zMinNumberOfParams) throws ExecutionException {
		if(getAllParameters().size() < zMinNumberOfParams) {
			throw new ExecutionException("Function requires minimum of "+zMinNumberOfParams+" parameters");
		}
	}
	
	/**
	 * Run it. And return a Value. 
	 * @return
	 */
	public abstract Value runFunction(Contract zContract) throws ExecutionException;

	/**
	 * Return a new copy of this function
	 * @return
	 */
	public abstract MinimaFunction getNewFunction();
	
	/**
	 * How many Parameters do you expect
	 */
	public abstract int requiredParams();
	
	/**
	 * Can be overridden in calsses that set a minimum
	 * @return
	 */
	public boolean isRequiredMinimumParameterNumber() {
		return false;
	}
	
	/**
	 * External function to do a quick check
	 */
	public void checkParamNumberCorrect() throws MinimaParseException {
		int paramsize = getAllParameters().size();
		int reqparam  = requiredParams();
		
		if(isRequiredMinimumParameterNumber()) {
			if(paramsize < reqparam) {
				throw new MinimaParseException(getName()+" function requires a  minimum of "+reqparam+" parameters not "+paramsize);
			}
		}else {
			if(paramsize != reqparam) {
				throw new MinimaParseException(getName()+" function requires exactly "+reqparam+" parameters not "+paramsize);
			}
		}
	}
	
	/**
	 * Get a specific function given it's name
	 * 
	 * @param zFunction
	 * @return the Function
	 * @throws MinimaParseException
	 */
	public static MinimaFunction getFunction(String zFunction) throws MinimaParseException{
		//Cycle through all the functions - find the right one..
		for(MinimaFunction func : MinimaFunction.ALL_FUNCTIONS) {
			//Check it..
			if(func.getName().equalsIgnoreCase(zFunction)) {
				return func.getNewFunction();
			}
		}
		
		throw new MinimaParseException("Invalid Function : "+zFunction);
	}
	
}
