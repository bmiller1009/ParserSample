package parser;

import java_cup.runtime.Symbol;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;

public class Driver
{
	/**
	 * set to true if you want to study the parsing process
	 */

	static boolean do_debug_parse = false;

	String[] my_args;

	public static void main(String[] args)
	{
		Driver d = new Driver(args);
		d.run();
	}

	public Driver(String[] args)
	{
		my_args = args;
	}

	int func(int i)
	{
		return 1;
	}

	public void run()
	{
		System.out.println("parsing [" + my_args[0] + "]");

		try
		{
			FileReader reader = new FileReader(new File(my_args[0]));
			Lexer mylexer = new Lexer(reader);

			parser my_parser = new parser(mylexer, my_args[0]);

			Symbol top;

			try
			{
				if (do_debug_parse)
					top = my_parser.debug_parse();
				else
					top = my_parser.parse();

				// Stop if parsing failed
				if (my_parser.hasFailed())
					return;

				System.out.println("Parsing Completed. Top symbol = "
					+ top.toString());

			}
			catch (Error e)
			{
				System.out.println("error(1) was:" + e.toString());
			}
			catch (Exception e)
			{
				/* do cleanup here -- possibly rethrow e */
				System.out.println("error(2) was:" + e.toString());
			}
			finally
			{
				/* do close out here */
			}
		}
		catch (FileNotFoundException e)
		{
			e.printStackTrace();
		}
	}
}
