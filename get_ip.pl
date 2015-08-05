#!/usr/bin/perl
use Encode;
use JSON;
use Data::Dumper;

#my $json = `qingcloud iaas describe-instances --limit 1000 --status running -f '/root/.qingcloud/pek2.yaml'`;
#my $text = decode_json($json);
#print  Dumper($text);

my $line;
while(<>){
        $line.=$_;
}

my $json = new JSON;
my $text = $json->decode($line);
&get_ips($text->{'instance_set'});
#my $instances = $text->{'instance_set'};
#print  Dumper($text->{'instance_set'});

sub get_ips{
        my $instances = shift;
        foreach my $instance (@$instances){
                #print  Dumper($instance);
                my $name = $instance->{'instance_name'} || "";
                my $private_ip = $instance->{'vxnets'}->[0]->{'private_ip'} || "";
                my $eip_addr   = $instance->{'eip'}->{'eip_addr'} || "";
                print "$private_ip;$eip_addr;$name;\n";
        }
}
