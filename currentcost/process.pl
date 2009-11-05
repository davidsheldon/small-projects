#!/usr/bin/perl

use POSIX qw(strftime);
use FileHandle;

use Date::Manip;

my $dob = '2008-08-03';
my $dateOffset = UnixDate(ParseDate($dob), "%s");


sub processLine {
  my $line = shift;

  $line =~ m{<date>(.*)</date>};
  my $date =  $1;

  my ($day, $hour,$min, $sec) = ($date =~ m{<\w+>(\d+)</\w+>}g);

  $line =~ m{<id>(.*)</id>};
  my $id = $1;
	
  my $watts = 0;
  foreach ($line =~ m{<watts>(.*?)</watts>}g) {
    $watts += $_;
  }
	
  $line =~ m{<tmpr>(.*)</tmpr>};
  my $temp = $1;
	
  #my $unixtime =  $dateOffset + ($day * 86400) + ($hour * 3600) + ($min*60) + $sec;
  my $unixtime = time; 
  my $retDate =strftime("%Y-%m-%d %H:%M:%S", localtime($unixtime));

  my $outputFile = strftime("logs/%Y-%m-%d-power.log", localtime($unixtime));

  output($outputFile, "$retDate $id $watts $temp");
}

my $currentFile;
my $fh;

sub output {
  my ($file, $data) = @_;

  if ($file ne $currentFile) {
    $fh = new FileHandle(">>$file")
       or die "Unable to open $file for writing: $!";
  }
  $fh -> print($data ."\n");
}

mkdir "logs" unless -d "logs";

while(<>) {
  processLine($_);
}
