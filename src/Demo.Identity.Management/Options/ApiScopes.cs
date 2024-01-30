namespace Demo.Identity.Management.Options
{
    public record ApiScope()
    {
        public string Value { get; init; }
        public string Description { get; init; }
    }

    public record ApiScopes()
    {
        public IEnumerable<ApiScope> Scopes{ get; init; }
    }
}
