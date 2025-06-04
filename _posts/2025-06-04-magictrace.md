---
title: 'Use Magic-Trace to profile your program'
date: 2025-06-04
permalink: /posts/2025/06/matrictrace/
tags:
  - profiling
  - Linux
---

Tired of manually timing function invocations in the code, or using `perf` tool or FlameGraph? Give Magic-Trace a try!

How to performance profile your code correctly?
======
If you frequently time pieces of your code in C, C++, Rust, etc., you are probably familiar with timing APIs such as `std::chrono::high_resolution_clock`, `clock_gettime`, or `std::time::Instant`. While they are great in timing your programs in a coarser granularity (they usually incur an inherent overhead of 10s-100s of nanoseconds). You are likely to explore measuring CPU cycles (`rdtsc`) soon because it has much lower overhead, but still, freqeuntly collecting data points can greatly slow down a performance sensitive program.

Perf tools
------
A better approach is to use Linux in-built [`perf` tools](https://perfwiki.github.io/main/) and [FlameGraph](https://github.com/brendangregg/FlameGraph). Internally, they use performance counters (hardware-level registers) for collecting performances stats, so much less overhead is incurred compared to measuring in software. However, their interfaces are not particualrly friendly, also, they only show an aggregated percentage of which each function takes up amongst the entire execution duration. Therefore, if we are looking for a tool that measures the absolute time of each function invocation, we need something else.

Magic Trace
======
What comes to our rescue is [`magic-trace`](https://github.com/janestreet/magic-trace). Internally, `magic-trace` uses Intel Processor Trace to take snapshots of all control flow, and they visuallize the performance in a much clearer and more interactive way than FlameGraph. Similar to FlameGraph, users can zoom in and out of the execution stacks, but `magic-trace` and show the detailed breakdown of each function invocation as opposed to an aggregated percentage (see example illustrations in the `README`).

How to use?
------
The first step is to acquire the executable (follow `README` from the github page). Then the way to use is very similar to `perf` - point it to a function or attach it to a running process. I personally prefer attaching to a running program as usually we only need a very small duration of execution for analysis:
```
sudo magic-trace attach -multi-thread -working-directory /path/to/directory/for/intermediate/data -p $(pidof {process_name})
```
After `magic-trace` terminates, it generates a trace file named `trace.fxt` in the working directory from which we execute it.

View the trace
------
After we acquire the trace file, there are two ways to visualize.
1. Use the [online trace viewer](https://magic-trace.org/): simply upload the trace file
2. Host the trace viewer server yourself ([perfetto](https://perfetto.dev/docs/quickstart/trace-analysis)):\\
Problem with the online viewer is that the memory it can use is limited by the memory that the browser can allocate to a single tab (100s MB to GBs), which can be not enough for large traces (often the case if the target program is multithreaded). To host a local trace server:

```
# Download prebuilts (Linux and Mac only)
curl -LO https://get.perfetto.dev/trace_processor
chmod +x ./trace_processor

# Start a local trace processor instance to replace wasm module in the UI
trace_processor trace.fxt --httpd
```
Once, the server is up and running, go to [perfetto](https://perfetto.dev/docs/quickstart/trace-analysis), click on `Trace Viewer` tab.