package spacelift

import future.keywords.if

loki_logs_webhook_id := "${webhook_id}"

gen_stream := {
	"spaceliftStackID": input.run_updated.stack.id,
	"spaceliftStackName": input.run_updated.stack.name,
	"spaceliftStackState": input.run_updated.stack.state,
	"spaceliftStackBranch": input.run_updated.stack.branch,
	"spaceliftStackRepository": input.run_updated.stack.repository,
	"spaceliftRunID": input.run_updated.run.id,
}

gen_wb_data := result if {
	result := {
		"endpoint_id": loki_logs_webhook_id,
		"payload": {"streams": [{
			"stream": gen_stream,
			"values": [
				[
					sprintf("%d", [input.run_updated.run.updated_at]),
					sprintf("Spacelift Stack is %s: %s", [input.run_updated.run.state, input.run_updated.urls.run]),
				],
				[
					sprintf("%d", [input.run_updated.run.updated_at]),
					sprintf("%v", [input]),
				],
			],
		}]},
		"method": "POST",
		"headers": {"custom-header": "custom"},
	}
}

webhook[wbdata] {
	input.run_updated.run.type == "TRACKED"
	input.run_updated.state == "INITIALIZING"
	wbdata := gen_wb_data
}

webhook[wbdata] {
	input.run_updated.run.type == "TRACKED"
	input.run_updated.state == "PLANNING"
	wbdata := gen_wb_data
}

webhook[wbdata] {
	input.run_updated.run.type == "TRACKED"
	input.run_updated.state == "FINISHED"
	wbdata := gen_wb_data
}

sample := true
