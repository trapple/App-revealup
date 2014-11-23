package App::revealup::cli;
use App::revealup::base;

sub run {
    my ($self, @args) = @_;

    local @ARGV = @args;
    my @commands;
    push @commands, @ARGV;
    my $command = shift @commands;

    if($command) {
        my $klass = sprintf("App::revealup::cli::%s", lc($command));
        $klass = 'server' if $klass eq 'serve';
        no warnings 'ambiguous';
        if(eval "require $klass;1;"){
            $klass->run(@commands);
            exit;
        }
    }
    system "perldoc App::revealup";
}

1;
