package Data::Clean::ToNonStringyNumber;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use parent qw(Data::Clean);
use vars qw($creating_singleton);

sub command_replace_with_non_stringy_number {
    require Scalar::Util::LooksLikeNumber;

    my ($self, $args) = @_;
    return '{{var}} = Scalar::Util::LooksLikeNumber::looks_like_number({{var}}) =~ /\\A(?:1|5|9|13)\\z/ ? {{var}}+0 : {{var}}';
}

sub new {
    my ($class, %opts) = @_;

    if (!%opts && !$creating_singleton) {
        warn "You are creating a new ".__PACKAGE__." object without customizing options. ".
            "You probably want to call get_cleanser() yet to get a singleton instead?";
    }

    $opts{""} //= ['replace_with_non_stringy_number'];
    $class->SUPER::new(%opts);
}

sub get_cleanser {
    my $class = shift;
    local $creating_singleton = 1;
    state $singleton = $class->new;
    $singleton;
}

1;
# ABSTRACT: Convert stringy numbers in data to non-stringy numbers

=for Pod::Coverage ^(new|command_.+)$

=head1 SYNOPSIS

 use Data::Clean::ToNonStringyNumber;
 my $cleanser = Data::Clean::ToNonStringyNumber->get_cleanser;
 my $data     = ["a", 1, "1.2", []];
 my $cleaned  = $cleanser->clean_in_place($data); # -> ["a", 1, 1.2, []]


=head1 DESCRIPTION

This class can convert stringy numbers in your data to non-stringy ones.


=head1 METHODS

=head2 CLASS->get_cleanser => $obj

Return a singleton instance.

=head2 $obj->clean_in_place($data) => $cleaned

Clean $data. Modify data in-place.

=head2 $obj->clone_and_clean($data) => $cleaned

Clean $data. Clone $data first.


=head1 SEE ALSO

L<Data::Clean::ToStringyNumber>

=cut
