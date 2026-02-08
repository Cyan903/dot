import "colors" as colors;
import "hosts" as hosts;

private fn get_host(S) {
    for host in hosts::devices.keys() {
        if hosts::devices[host].name == S { return hosts::devices[host]; }
    }

    return "";
};

private fn validate_requires(requirements) {
    if requirements.len == 0 { return true; }

    for cmd in requirements {
        if io::command_available(cmd) { return true; }
    }

    return false;
};

private fn validate_hosts(allowed_hosts, host) {
    allowed_hosts.contains(host);
};

private fn validate_tags(allowed_tags, host) {
    if allowed_tags.len == 0 { return true; }

    for tag in allowed_tags {
        if !host.tags.contains(tag) { return false; }
    }

    return true;
};

fn enabled(S, cfg) {
    let host = get_host(S);

    return !(
        host == ""

        // Check host
        || !validate_requires(cfg.requires)
        || !validate_hosts(cfg.hosts, host)
        || !validate_tags(cfg.tags, host)
    );
};

fn color(S) {
    let host = get_host(S);

    if host == "" {
        return colors::dracula;
    }

    return host.color;
}

fn wayland(S) {
    let host = get_host(S);

    if host == "" {
        return false;
    }

    return host.tags.contains("wayland");
}

// vim: syntax=rust
