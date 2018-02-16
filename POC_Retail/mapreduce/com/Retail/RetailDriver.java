package com.Retail;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
//import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
//import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.LazyOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

//Driver Class
public class RetailDriver {

	public static void main(String[] args) throws Exception,InterruptedException, ClassNotFoundException
	{
		
		//Configuration conf = new Configuration();
		
		GenericOptionsParser parser = new GenericOptionsParser(args);
		args = parser.getRemainingArgs();
		
		Job job = new Job();
		
	//	job.setInputFormatClass(TextInputFormat.class);
		job.setJarByClass(RetailDriver.class);
		
		job.setMapperClass(RetailMapper.class);
		job.setReducerClass(RetailReducer.class);
		
	//	job.setOutputFormatClass(TextOutputFormat.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);

		job.setNumReduceTasks(6);
		
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));

		LazyOutputFormat.setOutputFormatClass(job, TextOutputFormat.class);
		
		MultipleOutputs.addNamedOutput(job, "HighBuzzProduct", TextOutputFormat.class, Text.class, Text.class);
		MultipleOutputs.addNamedOutput(job, "NormalProduct", TextOutputFormat.class, Text.class, Text.class);
		MultipleOutputs.addNamedOutput(job, "RareProduct", TextOutputFormat.class, Text.class, Text.class);
		MultipleOutputs.addNamedOutput(job, "OnDemandCrawlProduct", TextOutputFormat.class, Text.class, Text.class);
		MultipleOutputs.addNamedOutput(job, "AvailableProduct", TextOutputFormat.class, Text.class, Text.class);
		MultipleOutputs.addNamedOutput(job, "OtherProducts", TextOutputFormat.class, Text.class, Text.class);
		
		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}
