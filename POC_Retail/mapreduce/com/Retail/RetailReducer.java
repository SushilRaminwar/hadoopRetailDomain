package com.Retail;


import java.io.IOException;


import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;

//Reducer Class
public class RetailReducer extends Reducer<Text, Text, Text, Text> 
{
	
	MultipleOutputs<Text,Text> mos;
	
	public void setup(Context context)
	{
		mos = new MultipleOutputs<Text,Text>(context);
	}
	
	protected void reduce (Text key, Iterable<Text> values,	Context context) throws IOException, InterruptedException 
	{
		
		String RTLName = "";
		String TypeOfCrawling = "";
		String  Prod_URL = "";
		String Title = "";
		float SalePrice = 0.0f;
		float RegPrice = 0.0f;
		int RebatePercent = 0;
		String StockInfo = "";
		String record = "";
		
		
		for (Text value : values) 
		{
			String[] recordSplit = value.toString().split("\t");
			
			RTLName =  recordSplit[0];
			TypeOfCrawling = recordSplit[1];
			Prod_URL = recordSplit[2];
			Title = recordSplit[3];
			SalePrice = Float.parseFloat(recordSplit[4]);
			RegPrice = Float.parseFloat(recordSplit[5]);
			RebatePercent = Integer.parseInt(recordSplit[6]);
			StockInfo = recordSplit[7];		
			record = RTLName+"\t"+TypeOfCrawling+"\t"+Prod_URL+"\t"+Title+"\t"+SalePrice+"\t"+RegPrice+"\t"+RebatePercent+"\t"+StockInfo;		
				
				if(TypeOfCrawling.equals("BS"))
				{
					if(salePrice<100.00 && RebatePercent>50)
					{
						//"High Buzz Product"
						mos.write("HighBuzzProduct", key, new Text(record),"/'$RetailMROutputpath'/HighBuzzProduct" );
					}
					if(RegPric<150.00 && (RebatePercent>25 && RebatePercent<50))
					{
						//"Normal Product"	
						mos.write("NormalProduct", key, new Text(record),"/'$RetailMROutputpath'/NormalProduct" );
					}
					if(Title.length()>100)
					{
					//"Rare Product"
					mos.write("RareProduct", key, new Text(record),"/'$RetailMROutputpath'/RareProduct" );
					}
				}
				else if(TypeOfCrawling.equals("ODC"))
				{
					if(SalePrice<150.00)
					{		
						//"On Demand Crawl Product"
						mos.write("OnDemandCrawlProduct", key, new Text(record),"/'$RetailMROutputpath'/OnDemandCrawlProduct" );
					}			
					if(StockInfo.equals("InStock"))
					{
						//"Available Product"
						mos.write("AvailableProduct", key, new Text(record),"/'$RetailMROutputpath'/AvailableProduct" );
					}
				}
				else 
				{
					//"Other Products"
					mos.write("OtherProducts", key, new Text(record),"/'$RetailMROutputpath'/OtherProducts" );
				}
		}
	}	
	
	protected void cleanup(Context context) throws IOException, InterruptedException 
	{
	  mos.close();
	}
	
}
