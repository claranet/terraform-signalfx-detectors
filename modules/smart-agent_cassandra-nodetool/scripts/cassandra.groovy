// Query the JMX endpoint for a single MBean.
ss = util.queryJMX("org.apache.cassandra.db:type=StorageService").first()

// Copied and modified from https://github.com/apache/cassandra
def parseFileSize(String value) {
	if (!value.matches("\\d+(\\.\\d+)? (GiB|KiB|MiB|TiB|bytes|GB|KB|MB|TB)")) {
		throw new IllegalArgumentException(
			String.format("value %s is not a valid human-readable file size", value));
	}
	if (value.endsWith(" TiB")) {
		return Math.round(Double.valueOf(value.replace(" TiB", "")) * 1.1e12);
	}
	else if (value.endsWith(" GiB")) {
		return Math.round(Double.valueOf(value.replace(" GiB", "")) * 1.074e9);
	}
	else if (value.endsWith(" KiB")) {
		return Math.round(Double.valueOf(value.replace(" KiB", "")) * 1024);
	}
	else if (value.endsWith(" MiB")) {
		return Math.round(Double.valueOf(value.replace(" MiB", "")) * 1.049e6);
	}
	else if (value.endsWith(" bytes")) {
		return Math.round(Double.valueOf(value.replace(" bytes", "")));
	}
  else if (value.endsWith(" TB")) {
		return Math.round(Double.valueOf(value.replace(" TB", "")) * 1e12);
	}
	else if (value.endsWith(" GB")) {
		return Math.round(Double.valueOf(value.replace(" GB", "")) * 1e9);
	}
	else if (value.endsWith(" KB")) {
		return Math.round(Double.valueOf(value.replace(" KB", "")) * 1e3);
	}
	else if (value.endsWith(" MB")) {
		return Math.round(Double.valueOf(value.replace(" MB", "")) * 1e6);
	}
	else {
		throw new IllegalStateException(String.format("FileUtils.parseFileSize() reached an illegal state parsing %s", value));
	}
}

localEndpoint = ss.HostIdToEndpoint.get(ss.LocalHostId)
dims = [host_id: ss.LocalHostId, cluster_name: ss.ClusterName]

output.sendDatapoints([
	// Equivalent of "Up/Down" in the `nodetool status` output.
	// 1 = Live; 0 = Dead; -1 = Unknown
	util.makeGauge(
		"cassandra.status",
		ss.LiveNodes.contains(localEndpoint) ? 1 : (ss.DeadNodes.contains(localEndpoint) ? 0 : -1),
		dims),

	util.makeGauge(
		"cassandra.state",
		ss.JoiningNodes.contains(localEndpoint) ? 3 : (ss.LeavingNodes.contains(localEndpoint) ? 2 : 1),
		dims),

	util.makeGauge(
		"cassandra.load",
		parseFileSize(ss.LoadString),
		dims),

	util.makeGauge(
		"cassandra.ownership",
		ss.Ownership.get(InetAddress.getByName(localEndpoint)),
		dims)
	])
