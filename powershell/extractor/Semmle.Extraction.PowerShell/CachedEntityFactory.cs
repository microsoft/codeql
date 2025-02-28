namespace Semmle.Extraction.PowerShell
{
    /// <summary>
    /// A factory for creating cached entities.
    /// </summary>
    internal abstract class CachedEntityFactory<TInit, TEntity>
        : Extraction.CachedEntityFactory<TInit, TEntity> where TEntity : CachedEntity
    {
        /// <summary>
        /// Initializes the entity, but does not generate any trap code.
        /// </summary>
        public sealed override TEntity Create(Context cx, TInit init)
        {
            return Create((PowerShellContext)cx, init);
        }

        public abstract TEntity Create(PowerShellContext cx, TInit init);
    }
}